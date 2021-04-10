//
//  WordSourceTest.swift
//  PalindromeTests
//
//  Created by Virgilius Santos on 21/10/18.
//  Copyright © 2018 Virgilius Santos. All rights reserved.
//
import Quick
import Nimble
import Swinject

@testable import Palindrome

class WordSourceTest: QuickSpec {

    class Teste {
        var indice = 0
    }
    override func spec() {
        var container: Container!
        beforeEach {
            container = Container()
            container.register(WordSourceProtocol.self) { _ in WordSource() }
                .inObjectScope(.container)
            container.register(Teste.self) { _ in Teste() }
        }
        
        it("POC singleton") {
            let t1 = container.resolve(Teste.self)!
            let t2 = container.resolve(Teste.self)!
            t1.indice = 3
            t2.indice = 7
            expect(t1.indice).toNot(equal(t2.indice))
            
            let ds1 = container.resolve(WordSourceProtocol.self)!
            let ds2 = container.resolve(WordSourceProtocol.self)!
            ds1.saveWord("teret")
            ds2.saveWord("tyuyt")
            expect(ds1.numberOfWords()).to(equal(ds2.numberOfWords()))
            
            let wd = ds1.word(row: 0)
            ds1.saveWord(wd)
            let count = ds1.numberOfWords()
            ds2.deleteWord(row: 0)
            expect(ds1.numberOfWords()).to(equal(count-1))
            for i in 0..<ds1.numberOfWords(){
                expect(ds1.word(row: i)).toNot(equal(wd))
            }
        }
    }

}
