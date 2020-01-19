//
//  VResponseDataTests.swift
//  VServiceTests
//
//  Created by Virgilius Santos on 18/01/20.
//  Copyright © 2020 Virgilius Santos. All rights reserved.
//

import Nimble
import Quick
@testable import VCore
@testable import VService

class VResponseDataTests: QuickSpec {
    var decodeMock: DecodableMock!
    var data: Data!
    var sut: VResponseData<DecodableMock>!

    override func spec() {
        super.spec()

        describe("usando com um decodable") {
            context("inicializado sem argumentos") {
                it("deve retornar o objecto") {
                    expect {
                        let sut = VResponseData<DecodableMock>()
                        let data = try DecodableMock(teste: 9).data()
                        let decodeMock = try sut.decode(data)
                        expect(decodeMock.teste).to(equal(9))
                    }.toNot(throwError())
                }
            }

            context("inicializado apenas com o tipo") {
                it("deve retornar o objecto") {
                    expect {
                        let sut = VResponseData(type: DecodableMock.self)
                        let data = try DecodableMock(teste: 9).data()
                        let decodeMock = try sut.decode(data)
                        expect(decodeMock.teste).to(equal(9))
                    }.toNot(throwError())
                }
            }

            context("inicializado com a closure") {
                it("deve retornar o objecto") {
                    expect {
                        let sut = VResponseData { try DecodableMock.decode(data: $0) }
                        let data = try DecodableMock(teste: 9).data()
                        let decodeMock = try sut.decode(data)
                        expect(decodeMock.teste).to(equal(9))
                    }.toNot(throwError())
                }
            }
        }
    }

    struct DecodableMock: Codable {
        var teste: Int
    }
}
