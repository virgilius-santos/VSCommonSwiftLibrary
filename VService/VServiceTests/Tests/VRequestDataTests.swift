//
//  VServiceTests.swift
//  VServiceTests
//
//  Created by Virgilius Santos on 17/01/20.
//  Copyright © 2020 Virgilius Santos. All rights reserved.
//

import Nimble
import Quick
@testable import VService

class VRequestDataTests: QuickSpec {
    override func spec() {
        super.spec()

        describe("tipos de valores associados") {
            var sut: VRequestData!

            context("apenas a url é informada") {
                beforeEach {
                    sut = VRequestData(urlString: "http://www.google.com")
                }

                it("deve ser possivel recuperar a url") {
                    expect(sut.urlString).to(equal("http://www.google.com"))
                }

                it("os campos devem ser vazios") {
                    expect(sut.paths).to(beEmpty())
                    expect(sut.queryParameters).to(beNil())
                    expect(sut.body).to(beNil())
                }

                it("a url deve ser formatada") {
                    expect(sut.url).toNot(beNil())
                    expect(sut.url).to(equal(URL(string: "http://www.google.com")))
                }
            }

            context("paths são informados") {
                beforeEach {
                    sut = VRequestData(urlString: "http://www.google.com", paths: ["image", 123])
                }

                it("deve ser possivel recuperar a url") {
                    expect(sut.urlString).to(equal("http://www.google.com"))
                }

                it("os campos nao informdos devem ser vazios") {
                    expect(sut.queryParameters).to(beNil())
                    expect(sut.body).to(beNil())
                }

                it("deve ser possivel recuperar o path") {
                    expect(sut.paths.count).to(equal(2))
                    expect(sut.paths[0]).to(equal("image"))
                    expect(sut.paths[1]).to(equal("123"))
                }

                it("a url deve ser formatada") {
                    expect(sut.url).toNot(beNil())
                    expect(sut.url).to(equal(URL(string: "http://www.google.com/image/123")))
                }
            }

            context("querys são informadas") {
                beforeEach {
                    sut = VRequestData(urlString: "http://www.google.com",
                                       queryParameters: [("user", "joao"), ("device", 123)])
                }

                it("deve ser possivel recuperar a url") {
                    expect(sut.urlString).to(equal("http://www.google.com"))
                }

                it("os campos devem ser vazios") {
                    expect(sut.paths).to(beEmpty())
                    expect(sut.body).to(beNil())
                }

                it("deve ser possivel recuperar a query") {
                    expect(sut.queryParameters?.count).to(equal(2))
                    expect(sut.queryParameters?[0].key).to(equal("user"))
                    expect(sut.queryParameters?[0].value).to(equal("joao"))
                    expect(sut.queryParameters?.count).to(equal(2))
                }

                it("a url deve ser formatada") {
                    expect(sut.url).toNot(beNil())
                    expect(sut.url).to(equal(URL(string: "http://www.google.com?user=joao&device=123")))
                }

                context("uma query é adicionada") {
                    beforeEach {
                        sut.addQuery(key: "mais", value: 42)
                    }

                    it("a url deve ser atualizada") {
                        expect(sut.url).to(equal(URL(string: "http://www.google.com?user=joao&device=123&mais=42")))
                    }
                }

                context("uma header é adicionada") {
                    beforeEach {
                        sut.addHeader(key: "mais", value: 42)
                    }

                    it("deve ser possivel recupera-la") {
                        expect(sut.headers).toNot(beEmpty())
                        expect(sut.headers?[0].value).to(equal("42"))
                        expect(sut.headers?[0].key).to(equal("mais"))
                    }
                }

                context("um path é adicionado") {
                    beforeEach {
                        sut.add(path: "playlist")
                    }

                    it("a url deve ser atualizada") {
                        expect(sut.url).to(equal(URL(string: "http://www.google.com/playlist?user=joao&device=123")))
                    }
                }
            }
        }
    }
}
