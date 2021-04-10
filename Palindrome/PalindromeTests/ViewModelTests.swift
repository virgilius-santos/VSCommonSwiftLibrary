//
//  ViewControllerTests.swift
//  PalindromeTests
//
//  Created by Virgilius Santos on 21/10/18.
//  Copyright © 2018 Virgilius Santos. All rights reserved.
//

import Quick
import Nimble
import Swinject

@testable import Palindrome

class ViewModelTests: QuickSpec {
    class MockDataSource: WordSourceProtocol {
        
        var word = String()
        var words = [String]()
        
        func saveWord(_ string: String) {
            words.append(string)
        }
        
        func deleteWord(row: Int) {
            words.remove(at: row)
        }
        
        func numberOfWords() -> Int {
            return words.count
        }
        
        func word(row: Int) -> String {
            return words[row]
        }
        
    }
    
    override func spec() {
        var container: Container!
        beforeEach {
            container = Container()
            container.register(WordSourceProtocol.self) { _ in MockDataSource() }
            .inObjectScope(.container)
            container.register(ViewModelProtocol.self) { r in
                let vm = ViewModel()
                vm.dataSource = r.resolve(WordSourceProtocol.self)
                return vm
            }
        }
        
        it("verificando inicializacao") {
            let vm = container.resolve(ViewModelProtocol.self)!
            let ds = container.resolve(WordSourceProtocol.self)!
            
            expect(vm.numberOfWords()).to(equal(0))
            expect(ds.numberOfWords()).to(equal(0))
            expect(vm.isPalindrome.value).to(equal(false))
            
        }
        
        it("verificando uma nova palavra que seja um palindromo") {
            let vm = container.resolve(ViewModelProtocol.self)!
            vm.newWord("ovo")
            expect(vm.isPalindrome.value).to(equal(true))
        }
        
        it("verificando uma nova palavra que não seja um palindromo") {
            let vm = container.resolve(ViewModelProtocol.self)!
            vm.newWord("batata")
            expect(vm.isPalindrome.value).to(equal(false))
        }
        
        it("crud de um palindromo") {
            let vm = container.resolve(ViewModelProtocol.self)!
            let ds = container.resolve(WordSourceProtocol.self)!
            
            let wd = "ovo"
            vm.newWord(wd)
            waitUntil { done in
                vm.saveWord {
                    expect(vm.numberOfWords()).to(equal(1))
                    expect(vm.word(row: 0)).to(equal(wd))
                    done()
                }
            }
            
            expect(ds.numberOfWords()).to(equal(1))
            expect(ds.word(row: 0)).to(equal(wd))
            
            vm.deleteWord(row: 0){}
            
            expect(vm.numberOfWords()).to(equal(0))
            expect(ds.numberOfWords()).to(equal(0))
        }
        
        it("nova palavra nula") {
            let vm = container.resolve(ViewModelProtocol.self)!
            
            let wd: String? = nil
            vm.newWord(wd)
            expect(vm.isPalindrome.value).to(equal(false))
        }
    }
}




//class WeatherTableViewControllerSpec: QuickSpec {
//    class MockNetwork: Networking {
//        var requestCount = 0
//
//        func request(_ response: @escaping (Data?) -> ()) {
//            requestCount += 1
//        }
//    }
//
//    override func spec() {
//        var container: Container!
//        beforeEach {
//            container = Container()
//            container.register(Networking.self) { _ in MockNetwork() }
//                .inObjectScope(.container)
//            container.register(WeatherFetcher.self) { r in
//                WeatherFetcher(networking: r.resolve(Networking.self)!)
//            }
//            container.register(WeatherTableViewController.self) { r in
//                let controller = WeatherTableViewController()
//                controller.weatherFetcher = r.resolve(WeatherFetcher.self)
//                return controller
//            }
//        }
//
//        it("starts fetching weather information when the view is about appearing.") {
//            let network = container.resolve(Networking.self) as! MockNetwork
//            let controller = container.resolve(WeatherTableViewController.self)!
//
//            expect(network.requestCount) == 0
//            controller.viewWillAppear(true)
//            expect(network.requestCount).toEventually(equal(1))
//        }
//    }
//}
