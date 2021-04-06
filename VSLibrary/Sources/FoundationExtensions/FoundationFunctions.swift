
import Foundation
import os.log
import SystemConfiguration
import Functions

public func logIfError<B>(
  dso: UnsafeRawPointer = #dsohandle,
  log: OSLog = .default,
  file: String = #fileID,
  function: String = #function,
  line: Int = #line,
  _ f: @autoclosure () throws -> B
) throws -> B {
  do {
    return try f()
  } catch {
    os_log(.error, dso: dso, log: log, "%s:%s:%d: Error: %@", file, function, line, String(describing: error))
    throw error
  }
}

public var isInternetAvailable: Bool {
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
