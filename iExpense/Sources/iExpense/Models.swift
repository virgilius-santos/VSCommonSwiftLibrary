
import Foundation

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
    var installments: UInt8
    var startDate: Date
    var source: Source
    let recorrenceType: RecorrenceType = .recorrence
    
    init(
        id: UUID = .init(),
        desc: String = "Aluguel",
        value: Double = 2000,
        installments: UInt8 = 2,
        startDate: Date = .init(),
        source: Source = Source()
    ) {
        self.id = id
        self.desc = desc
        self.value = value
        self.installments = installments
        self.startDate = startDate
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
