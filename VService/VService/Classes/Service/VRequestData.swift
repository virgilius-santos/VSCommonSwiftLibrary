//
//  Start.swift
//  VService
//
//  Created by Virgilius Santos on 17/01/20.
//  Copyright © 2020 Virgilius Santos. All rights reserved.
//

import Foundation
import VCore

public typealias EntrySet = (key: Any, value: Any)

public enum VHttpMethod: String {
    case post, put, get, delete
}

public struct VRequestData {
    public let urlString: String
    public var queryParameters: [(key: String, value: String)]?
    public var paths: [String]
    public let body: Data?
    public let httpMethod: VHttpMethod
    public var headers: [(key: String, value: String)]?

    public init(
        urlString: String,
        queryParameters: [EntrySet]? = nil,
        paths: [Any] = [],
        body: Data? = nil,
        headers: [EntrySet]? = nil,
        httpMethod: VHttpMethod = VHttpMethod.get
    ) {
        self.urlString = urlString
        self.queryParameters = queryParameters?.map { (key: "\($0.key)", value: "\($0.value)") }
        self.paths = paths.map { "\($0)" }
        self.body = body
        self.headers = headers?.map { (key: "\($0.key)", value: "\($0.value)") }
        self.httpMethod = httpMethod
    }

    public var url: URL? {
        let url = paths.reduce(URL(string: self.urlString)) { $0?.appendingPathComponent($1) }
        let absoluteString = url?.absoluteString
        var urlComponents = URLComponents(string: absoluteString ?? "")
        urlComponents?.queryItems = queryParameters?.map { URLQueryItem(name: $0.key, value: $0.value) }
        return urlComponents?.url
    }

    mutating func add(path: Any) {
        paths.append("\(path)")
    }

    mutating func addQuery(key: Any, value: Any) {
        if queryParameters == nil { queryParameters = [] }
        queryParameters?.append((key: "\(key)", value: "\(value)"))
    }

    mutating func addHeader(key: Any, value: Any) {
        if headers == nil { headers = [] }
        headers?.append((key: "\(key)", value: "\(value)"))
    }
}

public extension VRequestData {
    init(
        urlString: String,
        queryParameters: [EntrySet]? = nil,
        paths: [Any] = [],
        headers: [EntrySet]? = nil,
        body: Encodable,
        httpMethod: VHttpMethod = VHttpMethod.get
    ) throws {
        self.init(
            urlString: urlString,
            queryParameters: queryParameters,
            paths: paths,
            body: try body.data(),
            headers: headers,
            httpMethod: httpMethod
        )
    }

    init(
        urlString: String,
        queryParameters: [EntrySet]? = nil,
        paths: [Any] = [],
        body: [String: Any],
        headers: [EntrySet]? = nil,
        httpMethod: VHttpMethod = VHttpMethod.get
    ) throws {
        self.init(
            urlString: urlString,
            queryParameters: queryParameters,
            paths: paths,
            body: try body.data(),
            headers: headers,
            httpMethod: httpMethod
        )
    }
}
