//
//  VSessionTests.swift
//  VServiceTests
//
//  Created by Virgilius Santos on 18/01/20.
//  Copyright © 2020 Virgilius Santos. All rights reserved.
//

import Nimble
import OHHTTPStubs.Swift
import Quick
@testable import VService

class VSessionTests: QuickSpec {
    var sut: VSession!
    var requestData: VRequestData!
    var config: VConfiguration!
    var request: URLRequest!

    override func spec() {
        super.spec()

        describe("inicializando uma request") {
            context("inicializar parametros") {
                beforeEach {
                    self.config = .init(cachePolicy: VConfiguration.CachePolicy.reloadIgnoringCacheData,
                                        timeoutInterval: 3,
                                        headers: [(key: "bearer", value: "oiufhj")],
                                        configuration: URLSessionConfiguration.default)

                    self.sut = VSession(config: self.config)

                    self.requestData = VRequestData(urlString: "http://www.google.com",
                                                    queryParameters: [("user", 432)],
                                                    paths: [123, "card"],
                                                    body: try? ["id": 132].data(),
                                                    headers: [("application", "json")],
                                                    httpMethod: VHttpMethod.post)

                    self.request = try? self.sut.makeRequest(resquestData: self.requestData,
                                                             config: self.config)
                }

                it("verificar request") {
                    expect(self.requestData).toNot(beNil())
                    expect(self.config).toNot(beNil())
                    expect(self.request).toNot(beNil())

                    expect(self.request.allHTTPHeaderFields).toNot(beNil())
                    expect(self.request.value(forHTTPHeaderField: "application")).to(equal("json"))
                    expect(self.request.value(forHTTPHeaderField: "bearer")).to(equal("oiufhj"))

                    expect(self.request.timeoutInterval).to(equal(3))
                    expect(self.request.cachePolicy).to(equal(VConfiguration.CachePolicy.reloadIgnoringCacheData))

                    expect(self.request.url).to(equal(URL(string: "http://www.google.com/123/card?user=432")))

                    expect(self.request.httpBody).to(equal(try? ["id": 132].data()))

                    expect(self.request.httpMethod).to(equal("POST"))
                }

                it("validar criacao da session") {
                    let session = self.sut.makeSession(config: self.config)
                    let config = URLSessionConfiguration.default
                    config.timeoutIntervalForResource = self.config.timeoutInterval
                    expect(session.configuration).to(equal(config))
                }

                context("fazendo a request") {
                    it("reponse sem tratamento") {
                        stub(condition: isHost("www.google.com")) { _ in
                            let stubData = "Hello World!".data(using: .utf8,
                                                               allowLossyConversion: true)
                            return OHHTTPStubsResponse(data: stubData!,
                                                       statusCode: 200,
                                                       headers: nil)
                        }

                        waitUntil(timeout: 5) { done in
                            self.sut.request(resquest: self.requestData) { result in
                                switch result {
                                case let .success(data):
                                    expect(String(bytes: data,
                                                  encoding: String.Encoding.utf8))
                                        .to(equal("Hello World!"))
                                case let .failure(error):
                                    fail(String(describing: error))
                                }
                                done()
                            }
                        }
                    }

                    it("reponse Usando Decode") {
                        stub(condition: isHost("www.google.com")) { _ in
                            let stubData = try! DataMock(value: 45).data()
                            return OHHTTPStubsResponse(data: stubData,
                                                       statusCode: 200,
                                                       headers: nil)
                        }

                        waitUntil(timeout: 5) { done in
                            self.sut.request(resquest: self.requestData) { (result: Result<DataMock, VSessionError>) in
                                switch result {
                                case let .success(data):
                                    expect(data.value).to(equal(45))
                                case let .failure(error):
                                    fail(String(describing: error))
                                }
                                done()
                            }
                        }
                    }

                    it("reponse Usando a funçao completa") {
                        stub(condition: isHost("www.google.com")) { _ in
                            let stubData = try! DataMock(value: 45).data()
                            return OHHTTPStubsResponse(data: stubData,
                                                       statusCode: 200,
                                                       headers: nil)
                        }

                        waitUntil(timeout: 5) { done in
                            self.sut.request(resquest: self.requestData, response: DataMock.self) { result in
                                switch result {
                                case let .success(data):
                                    expect(data.value).to(equal(45))
                                case let .failure(error):
                                    fail(String(describing: error))
                                }
                                done()
                            }
                        }
                    }
                }

                context("recebendo erro da request") {
                    it("cancelando a request") {
                        stub(condition: isHost("www.google.com")) { _ in
                            let stubData = try! DataMock(value: 45).data()
                            return OHHTTPStubsResponse(data: stubData,
                                                       statusCode: 599,
                                                       headers: nil)
                                .requestTime(5, responseTime: 2)
                        }

                        waitUntil(timeout: 20) { done in
                            self.sut.request(resquest: self.requestData) { result in
                                switch result {
                                case .success:
                                    fail("deveria dar timeout")
                                case let .failure(error):
                                    expect(error.errorType).to(equal(.cancelled))
                                }
                                done()
                            }

                            self.sut.cancel()
                        }
                    }

                    it("reponse menor que 200") {
                        stub(condition: isHost("www.google.com")) { _ in
                            let stubData = try! DataMock(value: 45).data()
                            return OHHTTPStubsResponse(data: stubData,
                                                       statusCode: 199,
                                                       headers: nil)
                        }

                        waitUntil(timeout: 5) { done in

                            self.sut.request(resquest: self.requestData, response: DataMock.self) { result in
                                switch result {
                                case .success:
                                    fail("deveria dar erro")
                                case let .failure(error):
                                    expect(error.errorType).to(equal(.responseFailure))
                                }
                                done()
                            }
                        }
                    }

                    it("reponse maior que 299") {
                        stub(condition: isHost("www.google.com")) { _ in
                            let stubData = try! DataMock(value: 45).data()
                            return OHHTTPStubsResponse(data: stubData,
                                                       statusCode: 599,
                                                       headers: nil)
                        }

                        waitUntil(timeout: 5) { done in

                            self.sut.request(resquest: self.requestData) { result in
                                switch result {
                                case .success:
                                    fail("deveria dar erro")
                                case let .failure(error):
                                    expect(error.errorType).to(equal(.responseFailure))
                                }
                                done()
                            }
                        }
                    }

                    it("demora na resposta") {
                        stub(condition: isHost("www.google.com")) { _ in
                            let stubData = try! DataMock(value: 45).data()
                            return OHHTTPStubsResponse(data: stubData,
                                                       statusCode: 599,
                                                       headers: nil)
                                .requestTime(1, responseTime: 4)
                        }

                        waitUntil(timeout: 20) { done in
                            self.sut.request(resquest: self.requestData) { result in
                                switch result {
                                case .success:
                                    fail("deveria dar timeout")
                                case let .failure(error):
                                    expect(error.errorType).to(equal(.timedOut))
                                }
                                done()
                            }
                        }
                    }

                    it("demora na resposta com erro do servidor") {
                        stub(condition: isHost("www.google.com")) { _ in
                            let timedOutError = NSError(domain: NSURLErrorDomain, code: URLError.timedOut.rawValue)
                            return OHHTTPStubsResponse(error: timedOutError)
                        }

                        waitUntil(timeout: 20) { done in
                            self.sut.request(resquest: self.requestData) { result in
                                switch result {
                                case .success:
                                    fail("deveria dar timeout")
                                case let .failure(error):
                                    expect(error.errorType).to(equal(.timedOut))
                                }
                                done()
                            }
                        }
                    }

                    it("sem conexao") {
                        stub(condition: isHost("www.google.com")) { _ in
                            let notConnectedError = NSError(domain: NSURLErrorDomain, code: URLError.notConnectedToInternet.rawValue)
                            return OHHTTPStubsResponse(error: notConnectedError)
                        }

                        waitUntil(timeout: 20) { done in
                            self.sut.request(resquest: self.requestData) { result in
                                switch result {
                                case .success:
                                    fail("deveria dar erro")
                                case let .failure(error):
                                    expect(error.errorType).to(equal(.withoutConnection))
                                }
                                done()
                            }
                        }
                    }
                    
                    it("erro customizado") {
                        stub(condition: isHost("www.google.com")) { _ in
                            let stubData = try! DataMock(value: 45).data()
                            return OHHTTPStubsResponse(data: stubData,
                                                       statusCode: 200,
                                                       headers: nil)
                        }
                        
                        waitUntil(timeout: 5) { done in
                            
                            self.sut.request(resquest: self.requestData,
                                             response: DataMock.self,
                                             errorHandler: { (_,_) in CustomDummyError() }) { result in
                                switch result {
                                    case .success:
                                        fail("deveria dar erro")
                                    case let .failure(error):
                                        expect(error.errorType).to(equal(.custom))
                                        expect(error.originalError as? CustomDummyError).toNot(beNil())
                                }
                                done()
                            }
                        }
                    }
                }
            }
        }
    }
}

private struct DataMock: Codable {
    let value: Int
}

private struct CustomDummyError: Error {
    
}
