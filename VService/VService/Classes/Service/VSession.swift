//
//  VSession.swift
//  VService
//
//  Created by Virgilius Santos on 18/01/20.
//  Copyright © 2020 Virgilius Santos. All rights reserved.
//

import Foundation
import VCore

public typealias CustomErrorHandler = ((URLResponse?, Error?) -> Error?)

public protocol VSessionProtocol {
    func request<DataReceived>(resquest requestData: VRequestData,
                               response responseData: @escaping ((Data) throws -> DataReceived),
                               errorHandler: CustomErrorHandler?,
                               completion: ((Result<DataReceived, VSessionError>) -> Void)?)
}

public class VSession: VSessionProtocol {
    public let config: VConfiguration
    var dataTask: URLSessionDataTask?
    let errorHandler: VErrorHandler

    public init(config: VConfiguration = VConfiguration.default,
                errorHandler: VErrorHandler = VErrorHandler()) {
        self.config = config
        self.errorHandler = errorHandler
    }

    public func request<DataReceived>(resquest requestData: VRequestData,
                                      response responseData: @escaping ((Data) throws -> DataReceived),
                                      errorHandler customErrorHandler: CustomErrorHandler? = nil,
                                      completion: ((Result<DataReceived, VSessionError>) -> Void)?) {
        do {
            try errorHandler.checkConection()

            let request = try makeRequest(resquestData: requestData, config: config)

            let session = makeSession(config: config)

            let dataTask = session.dataTask(with: request) { [errorHandler] data, response, error in

                do {
                    if let err = errorHandler.build(error) {
                        logger.error("\(err) info:\(String(describing: error))")
                        throw err
                    }

                    if let err = errorHandler.build(response) {
                        logger.error("\(err) info:\(String(describing: response))")
                        throw err
                    }
                    
                    if let customErrorHandler = customErrorHandler,
                        let err = customErrorHandler(response,error) {
                        logger.error("\(err) info:\(String(describing: response))")
                        throw err
                    }

                    guard let data = data else {
                        throw errorHandler.build()
                    }

                    let objectDecoded = try responseData(data)
                    if let completion = completion {
                        completion(.success(objectDecoded))
                    }
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

    public func cancel() {
        dataTask?.cancel()
    }
}

extension VSessionProtocol {
    func request(resquest: VRequestData,
                 errorHandler customErrorHandler: CustomErrorHandler? = nil,
                 completion: ((Result<Data, VSessionError>) -> Void)? = nil) {
        
        request(resquest: resquest,
                response: { $0 },
                errorHandler: customErrorHandler,
                completion: completion)
    }

    func request<DataReceived: Decodable>(resquest: VRequestData,
                                          errorHandler customErrorHandler: CustomErrorHandler? = nil,
                                          completion: ((Result<DataReceived, VSessionError>) -> Void)? = nil) {
        request(resquest: resquest,
                response: { try DataReceived.decode(data: $0) },
                errorHandler: customErrorHandler,
                completion: completion)
    }

    func request<DataReceived: Decodable>(resquest: VRequestData,
                                          response: DataReceived.Type,
                                          errorHandler customErrorHandler: CustomErrorHandler? = nil,
                                          completion: ((Result<DataReceived, VSessionError>) -> Void)? = nil) {
        request(resquest: resquest,
                response: { try response.decode(data: $0) },
                errorHandler: customErrorHandler,
                completion: completion)
    }
}

extension VSession {
    func makeRequest(resquestData: VRequestData, config: VConfiguration) throws -> URLRequest {
        guard let url = resquestData.url else {
            logger.error("\(VSessionErrorType.urlInvalid) info:\(String(describing: resquestData.url))")
            throw VSessionErrorType.urlInvalid
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
        URLSession(configuration: config.configuration)
    }
}
