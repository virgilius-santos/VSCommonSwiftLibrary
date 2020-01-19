//
//  VSessionTests.swift
//  VServiceTests
//
//  Created by Virgilius Santos on 18/01/20.
//  Copyright © 2020 Virgilius Santos. All rights reserved.
//

import Nimble
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
                    self.sut = .init()

                    self.config = .init(cachePolicy: VConfiguration.CachePolicy.reloadIgnoringCacheData,
                                        timeoutInterval: 9,
                                        headers: [(key: "bearer", value: "oiufhj")],
                                        configuration: URLSessionConfiguration.default)

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

                    expect(self.request.timeoutInterval).to(equal(9))
                    expect(self.request.cachePolicy).to(equal(VConfiguration.CachePolicy.reloadIgnoringCacheData))

                    expect(self.request.url).to(equal(URL(string: "http://www.google.com/123/card?user=432")))

                    expect(self.request.httpBody).to(equal(try? ["id": 132].data()))

                    expect(self.request.httpMethod).to(equal("POST"))
                }

                it("validar criacao da session") {
                    let session = self.sut.makeSession(config: self.config)
                    expect(session.configuration).to(equal(URLSessionConfiguration.default))
                }
            }
        }
    }
}
