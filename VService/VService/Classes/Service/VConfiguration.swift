//
//  VConfiguration.swift
//  VService
//
//  Created by Virgilius Santos on 18/01/20.
//  Copyright © 2020 Virgilius Santos. All rights reserved.
//

import Foundation

public struct VConfiguration {
    public typealias CachePolicy = NSURLRequest.CachePolicy

    let cachePolicy: CachePolicy
    let timeoutInterval: TimeInterval
    var headers: [(key: String, value: String)]?
    let configuration: URLSessionConfiguration

    public init(cachePolicy: CachePolicy,
                timeoutInterval: TimeInterval,
                headers: [(key: String, value: String)]? = nil,
                configuration: URLSessionConfiguration = URLSessionConfiguration.ephemeral) {
        self.cachePolicy = cachePolicy
        self.timeoutInterval = timeoutInterval
        self.headers = headers
        self.configuration = configuration
        self.configuration.timeoutIntervalForResource = timeoutInterval
    }

    public static let `default` = VConfiguration(cachePolicy: CachePolicy.useProtocolCachePolicy,
                                                 timeoutInterval: TimeInterval(10))
}
