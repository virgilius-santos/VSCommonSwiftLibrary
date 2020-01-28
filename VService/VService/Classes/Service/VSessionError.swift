//
//  VSessionError.swift
//  VService
//
//  Created by Virgilius Santos on 19/01/20.
//  Copyright © 2020 Virgilius Santos. All rights reserved.
//

import Foundation
import SystemConfiguration
import VCore

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
}

public struct VErrorHandler {
    typealias RuleFunction = (Any?) -> VSessionError?

    public init() {}

    func checkConection() throws {
        if !isInternetAvailable {
            logger.error("\(VSessionErrorType.withoutConnection)")
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
        logger.error("\(VSessionErrorType.generic) info:\(String(describing: info))")
        return VSessionError(VSessionErrorType.generic)
    }
}

extension VErrorHandler {
    var isInternetAvailable: Bool {
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)

        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) { zeroSockAddress in

                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }

        var flags = SCNetworkReachabilityFlags()
        guard SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) else { return false }
        let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
        let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        return (isReachable && !needsConnection)
    }
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
            logger.error("\(VSessionErrorType.responseFailure) info:\(String(describing: $0))")
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
