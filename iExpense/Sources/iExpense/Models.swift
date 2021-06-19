
import Foundation
import LocalStorage

enum RecorrenceType: String, CaseIterable, Equatable {
    case fixed, recorrence
}

struct FixedValue: Equatable, Hashable {
    
    var id: UUID
    var desc: String
    var value: Double
    var day: Day
    var source: Source
    let recorrenceType: RecorrenceType = .fixed
    
    init(
        id: UUID = .init(),
        desc: String = "Aluguel",
        value: Double = 2000,
        day: Day = Day(),
        source: Source = Source()
    ) {
        self.id = id
        self.desc = desc
        self.value = value
        self.day = day
        self.source = source
    }
}

struct RecorrenceValue: Equatable, Hashable {
    
    var id: UUID
    var desc: String
    var value: Double
    var total: UInt8
    var current: UInt8
    var source: Source
    let recorrenceType: RecorrenceType = .recorrence
    
    var pawn: Double {
        value * Double(total - current)
    }
    
    init?(
        id: UUID = .init(),
        desc: String = "Aluguel",
        value: Double = 2000,
        total: UInt8 = 7,
        current: UInt8 = 3,
        source: Source = Source()
    ) {
        guard total >= current else { return nil }
        self.id = id
        self.desc = desc
        self.value = value
        self.total = total
        self.current = current
        self.source = source
    }
}

struct Source: Equatable, Hashable {
    var selected: String = "Nubank"
    let availables: [String] = ["Nubank", "Itau", "Way 9400", "Way 9880", "original"]
}

struct Day: Equatable, Hashable {
    var selected: UInt8 = 10
    let availables: [UInt8] = Array(1...30)
}

var currencyFormatter: NumberFormatter = {
    let f = NumberFormatter()
    f.numberStyle = .currency
    return f
}()

var decimalFormatter: NumberFormatter = {
    let f = NumberFormatter()
    f.allowsFloats = true
    f.maximumFractionDigits = 2
    f.minimumFractionDigits = 2
    f.numberStyle = .decimal
    return f
}()

var dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    return formatter
}()
