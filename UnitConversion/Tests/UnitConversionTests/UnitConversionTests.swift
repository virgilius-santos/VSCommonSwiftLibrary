
import XCTest
@testable import UnitConversion
import SnapshotTesting
import SwiftUI

final class UnitConversionTests: XCTestCase {
    typealias ConversionType = UnitViewModel.ConversionType
    func test_check_conversionTypes() {
        assertSnapshot(matching: ConversionType.allCases, as: .dump)
    }
    
    func test_validUI() {
        let vc = UIHostingController(rootView:  ContentView())
        vc.view.frame = UIScreen.main.bounds
        assertSnapshot(matching: vc, as: .image)
    }
    
    func test_resetUnitSelected() {
        var sut: UnitViewModel.Input = .init(
            value: "dummy", conversionType: .length,
            unitSelected: ConversionType.length.unitTypes[2]
        )
        
        let newConversionType = ConversionType.temperature
        sut.conversionType = newConversionType
        
        XCTAssertEqual(sut.unitSelected, newConversionType.unitTypes[0])
        
    }
    
    func test_typeSelectedUpdate() {
        var sut: UnitViewModel = .init(conversionType: .temperature, startValue: "27.0")
        
        sut.typeSelected = .length
        
        XCTAssertEqual(sut.firstInput.conversionType, .length)
        XCTAssertEqual(sut.secondInput.conversionType, .length)
    }
    
    func test_initialValues() {
        let sut: UnitViewModel = .init(conversionType: .temperature, startValue: "27.0")
                
        XCTAssertEqual(sut.secondInput.value, sut.secondInput.value)
    }
    
    func test_updateFirstInputValue() {
        var sut: UnitViewModel = .init(conversionType: .temperature, startValue: "27.0")
        
        sut.firstInput.value = "1000"
        
        XCTAssertEqual(sut.secondInput.value, "1273.15")
    }
    
    func test_updateSecondInputUnit() {
        var sut: UnitViewModel = .init(conversionType: .temperature, startValue: "1000")
        
        sut.secondInput.unitSelected = .kelvin
        XCTAssertEqual(sut.secondInput.value, "1273.15")
    }
}
