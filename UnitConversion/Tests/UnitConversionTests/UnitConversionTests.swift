
import XCTest
@testable import UnitConversion
import SnapshotTesting

final class UnitConversionTests: XCTestCase {
    typealias ConversionType = UnitViewModel.ConversionType
    func test_check_conversionTypes() {
        assertSnapshot(matching: ConversionType.allCases, as: .dump)
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
}
