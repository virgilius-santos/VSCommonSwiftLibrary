
import Foundation
import LocalStorage

public enum RecurrenceType: String, CaseIterable, Equatable {
    case fixed, recurrence
}

public struct FixedValue: Equatable, Hashable {
    
    var id: UUID
    var desc: String
    var value: Double
    var day: Day
    var source: Source
    let recurrenceType: RecurrenceType = .fixed
    
    init(
        id: UUID,
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

public struct RecurrenceValue: Equatable, Hashable {
    
    var id: UUID
    var desc: String
    var value: Double
    var total: UInt8
    var current: UInt8
    var source: Source
    let recurrenceType: RecurrenceType = .recurrence
    
    var pawn: Double {
        value * Double(total - current)
    }
    
    init(
        id: UUID,
        desc: String = "Aluguel",
        value: Double = 2000,
        total: UInt8 = 7,
        current: UInt8 = 3,
        source: Source = Source()
    ) {
        self.id = id
        self.desc = desc
        self.value = value
        self.total = total
        self.current = current
        self.source = source
    }
}

public struct Source: Equatable, Hashable {
    var selected: String = "Nubank"
    let availables: [String] = ["Nubank", "Itau", "Way 9400", "Way 9880", "original"]
}

public struct Day: Equatable, Hashable {
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

public struct BalanceLocalStorage {
    var getFixedValues: () -> [FixedValue]
    var getRecurrentValues: () -> [RecurrenceValue]
    
    var addFixedValue: (FixedValue) -> Void
    var addRecurrentValue: (RecurrenceValue) -> Void
    
    public init() {
        var fixedValues: [FixedValue] = [.init(id: .init()), .init(id: .init())]
        var recurrentValues: [RecurrenceValue] = [.init(id: .init()), .init(id: .init())]
        
        getFixedValues = { fixedValues }
        getRecurrentValues = { recurrentValues }
        
        addFixedValue = { fixedValues.append($0) }
        addRecurrentValue = { recurrentValues.append($0) }
    }
}
