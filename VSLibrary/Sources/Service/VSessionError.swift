
import Foundation
import FoundationExtensions

public struct VSessionError: Error {
  let errorType: VSessionErrorType
  let originalError: Error?
  
  init(_ errorType: VSessionErrorType, originalError: Error? = nil) {
    self.errorType = errorType
    self.originalError = originalError
  }
}

public enum VSessionErrorType: Error {
  case generic, urlInvalid, withoutConnection
  case responseFailure, timedOut, cancelled
  case custom
}

public struct VErrorHandler {
  typealias RuleFunction = (Any?) -> VSessionError?
  
  public init() {}
  
  func checkConection() throws {
    if !isInternetAvailable {
      logError(VSessionErrorType.withoutConnection)
      throw VSessionErrorType.withoutConnection
    }
  }
  
  func build(_ info: Any?) -> VSessionError? {
    VErrorHandler.rules.compactMap { $0(info) }.first
  }
  
  func build(_ info: Any? = nil) -> VSessionError {
    if let error = build(info) {
      return error
    }
    logError(VSessionErrorType.generic, info: info)
    return VSessionError(VSessionErrorType.generic)
  }
}

extension VErrorHandler {
 
}

extension VErrorHandler {
  static let rules: [RuleFunction] = [
    sessionErrorRule,
    sessionErrorTypeRule,
    responseRule,
    timedOutConnectionRule,
    withoutConnectionRule,
    cancelledRule,
    errorRule,
  ]
  
  static let sessionErrorRule: RuleFunction = { $0 as? VSessionError }
  
  static let sessionErrorTypeRule: RuleFunction = {
    if let err = $0 as? VSessionErrorType {
      return VSessionError(err)
    }
    return nil
  }
  
  static let responseRule: RuleFunction = {
    if let response = $0 as? HTTPURLResponse,
       response.statusCode < 200 || response.statusCode > 299 {
      logError(VSessionErrorType.responseFailure, info: $0)
      return VSessionError(VSessionErrorType.responseFailure)
    }
    return nil
  }
  
  static let withoutConnectionRule: RuleFunction = {
    if let err = $0 as? NSError, err.code == URLError.notConnectedToInternet.rawValue {
      return VSessionError(VSessionErrorType.withoutConnection, originalError: $0 as? Error)
    }
    return nil
  }
  
  static let timedOutConnectionRule: RuleFunction = {
    if let err = $0 as? NSError, err.code == URLError.timedOut.rawValue {
      return VSessionError(VSessionErrorType.timedOut, originalError: $0 as? Error)
    }
    return nil
  }
  
  static let cancelledRule: RuleFunction = {
    if let err = $0 as? NSError, err.code == URLError.cancelled.rawValue {
      return VSessionError(VSessionErrorType.cancelled, originalError: $0 as? Error)
    }
    return nil
  }
  
  static let errorRule: RuleFunction = {
    if $0 is Error {
      return VSessionError(VSessionErrorType.generic, originalError: $0 as? Error)
    }
    return nil
  }
}
