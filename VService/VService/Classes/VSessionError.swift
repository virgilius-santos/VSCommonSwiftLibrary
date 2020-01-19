//
//  VSessionError.swift
//  VService
//
//  Created by Virgilius Santos on 19/01/20.
//  Copyright © 2020 Virgilius Santos. All rights reserved.
//

import Foundation
import SystemConfiguration

public enum VSessionError: Error {
    case generic, urlInvalid, withoutConnection
}

public struct ErrorHandler {
    typealias RuleFunction = (Any?) -> VSessionError?

    let rules: [RuleFunction] = [
        sessionRule,
    ]

    public init() {}

    func checkConection() throws {
        if !isInternetAvailable {
            throw VSessionError.withoutConnection
        }
    }

    func build(_ info: Any?) -> VSessionError? {
        return rules.compactMap { $0(info) }.first
    }

    func build(_ info: Any? = nil) -> VSessionError {
        return build(info) ?? VSessionError.generic
    }
}

extension ErrorHandler {
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

    static var sessionRule: RuleFunction = { $0 as? VSessionError }
}
