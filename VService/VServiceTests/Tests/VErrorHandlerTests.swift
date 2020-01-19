//
//  VErrorHandlerTests.swift
//  VServiceTests
//
//  Created by Virgilius Santos on 19/01/20.
//  Copyright © 2020 Virgilius Santos. All rights reserved.
//

import Foundation
import Nimble
import Quick
@testable import VService

class VErrorHandlerTests: QuickSpec {
    var sut: VErrorHandler!

    override func spec() {
        super.spec()

        describe("check rules") {
            beforeEach {
                self.sut = .init()
            }

            it("retornar generic para uma regra desconhecida") {
                expect(self.sut.build(9) as VSessionError).to(equal(.generic))
            }

            it("retornar nil para uma regra desconhecida se for optional") {
                expect(self.sut.build(9) as VSessionError?).to(beNil())
            }

            it("sem informar parametros retornar generic") {
                expect(self.sut.build()).to(equal(.generic))
            }

            it("deve retornar o mesmo erro se for VSessionError") {
                expect(self.sut.build(VSessionError.urlInvalid)).to(equal(.urlInvalid))
            }
        }

        describe("responseFailure") {
            context("retornar erro") {
                it("se o codigo for menor que 200") {
                    expect(self.sut.build(CodeHTTPURLResponseMock(9))).to(equal(.responseFailure))
                }

                it("se o codigo for maior que 299") {
                    expect(self.sut.build(CodeHTTPURLResponseMock(309))).to(equal(.responseFailure))
                }
            }

            context("retornar nil") {
                it("se o codigo estiver entre 200 e 299") {
                    expect(self.sut.build(CodeHTTPURLResponseMock(200)) as VSessionError?).to(beNil())
                }
            }
        }
    }
}

private class CodeHTTPURLResponseMock: HTTPURLResponse {
    let _code: Int

    init(_ code: Int) {
        _code = code
        super.init(url: URL(string: "www.google.com")!,
                   mimeType: nil,
                   expectedContentLength: 0,
                   textEncodingName: nil)
    }

    required init?(coder _: NSCoder) {
        nil
    }

    override var statusCode: Int {
        _code
    }
}
