//
//  VSession.swift
//  VService
//
//  Created by Virgilius Santos on 18/01/20.
//  Copyright © 2020 Virgilius Santos. All rights reserved.
//

import Foundation

public class VSession {
    public let config: VConfiguration
    var dataTask: URLSessionDataTask?
    let errorHandler: ErrorHandler

    public init(config: VConfiguration = VConfiguration.default,
                errorHandler: ErrorHandler = ErrorHandler()) {
        self.config = config
        self.errorHandler = errorHandler
    }

    public func request<DataReceived>(resquest requestData: VRequestData,
                                      response responseData: VResponseData<DataReceived>,
                                      completion: ((Result<DataReceived, VSessionError>) -> Void)?) {
        do {
            try errorHandler.checkConection()

            let request = try makeRequest(resquestData: requestData, config: config)

            let session = makeSession(config: config)

            let dataTask = session.dataTask(with: request) { [errorHandler] data, response, error in

                do {
                    if let err = errorHandler.build(error) {
                        throw err
                    }

                    if let err = errorHandler.build(response) {
                        throw err
                    }

                    guard let data = data else {
                        throw errorHandler.build()
                    }

                    let objectDecoded = try responseData.decode(data)
                    completion?(.success(objectDecoded))
                } catch {
                    completion?(.failure(errorHandler.build(error)))
                }
            }

            self.dataTask = dataTask

            dataTask.resume()

        } catch {
            completion?(.failure(errorHandler.build(error)))
        }
    }

    func cancel() {
        dataTask?.cancel()
    }
}

extension VSession {
    func request(resquest: VRequestData, completion: ((Result<Data, VSessionError>) -> Void)? = nil) {
        request(resquest: resquest, response: VResponseData<Data>(), completion: completion)
    }

    func request<DataReceived: Decodable>(resquest: VRequestData,
                                          completion: ((Result<DataReceived, VSessionError>) -> Void)? = nil) {
        request(resquest: resquest, response: VResponseData<DataReceived>(), completion: completion)
    }
}

public extension VSession {
    func makeRequest(resquestData: VRequestData, config: VConfiguration) throws -> URLRequest {
        guard let url = resquestData.url else {
            throw VSessionError.urlInvalid
        }

        var request = URLRequest(url: url,
                                 cachePolicy: config.cachePolicy,
                                 timeoutInterval: config.timeoutInterval)

        request.httpMethod = resquestData.httpMethod.rawValue

        config.headers?.forEach { request.setValue($0.value, forHTTPHeaderField: $0.key) }
        resquestData.headers?.forEach { request.setValue($0.value, forHTTPHeaderField: $0.key) }

        request.httpBody = resquestData.body

        return request
    }

    func makeSession(config: VConfiguration) -> URLSession {
        return URLSession(configuration: config.configuration)
    }
}
