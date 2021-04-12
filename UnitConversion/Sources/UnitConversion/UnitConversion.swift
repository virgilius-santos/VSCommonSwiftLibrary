
import SwiftUI
import Functions

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct ContentView: View {
    
    @State private var viewModel = UnitViewModel()
    
    var body: some View {
        
        NavigationView {
            Form {
                Section(header: Text("Conversion Selected: \(viewModel.title)")) {
                    Picker("Select Conversion Type", selection: $viewModel.typeSelected) {
                        ForEach(viewModel.conversionTypes, id: \.self) {
                            Text($0.shortTitle)
                        }
                    }.pickerStyle(SegmentedPickerStyle())
                }
                
                Section(header: Text("Unit Selected: \(viewModel.firstInput.unitSelected.title)")) {
                    TextField("Value", text: $viewModel.firstInput.value)
                        .keyboardType(.decimalPad)
                    
                    Picker("Select Input Type", selection: $viewModel.firstInput.unitSelected) {
                        ForEach(viewModel.firstInput.unitTypes, id: \.self) {
                            Text($0.shortTitle)
                        }
                    }.pickerStyle(SegmentedPickerStyle())
                }
                
                Section(header: Text("Unit Selected: \(viewModel.secondInput.unitSelected.title)")) {
                    Text(viewModel.secondInput.value)
                    
                    Picker("Select Input Type", selection: $viewModel.secondInput.unitSelected) {
                        ForEach(viewModel.secondInput.unitTypes, id: \.self) {
                            Text($0.shortTitle)
                        }
                    }.pickerStyle(SegmentedPickerStyle())
                }
            }
            .navigationBarTitle("Unit Conversion")
        }
        
    }
}


struct UnitViewModel: Identifiable {
    
    let id = UUID()
    
    let conversionTypes = ConversionType.allCases
    
    var types: [String] { conversionTypes.map(\.title) }
    
    var typeSelected: ConversionType {
        didSet {
            firstInput.conversionType = typeSelected
            secondInput.conversionType = typeSelected
        }
    }
    
    var title: String { typeSelected.title }
    
    var firstInput: Input {
        didSet { updateSecond() }
    }
    
    var secondInput: Input {
        didSet {
            if let value = oldValue.resetValue(to: secondInput) {
                secondInput.value = value
            }
        }
    }
    
    init(
        conversionType: ConversionType = .temperature,
        startValue: String = "0.0"
    ) {
        precondition(!conversionType.unitTypes.isEmpty)
        typeSelected = conversionType
        
        firstInput = .init(
            value: startValue,
            conversionType: conversionType,
            unitSelected: conversionType.unitTypes[0]
        )
        
        secondInput = .init(
            value: startValue,
            conversionType: conversionType,
            unitSelected: conversionType.unitTypes.last!
        )
        
        updateSecond()
    }
    
    private mutating func updateSecond() {
        let unitString = firstInput.convert(to: secondInput)
        secondInput.value = unitString
    }
}

extension UnitViewModel {
    struct Input {
        var value: String
        var conversionType: ConversionType {
            didSet { unitSelected = conversionType.unitTypes[0] }
        }
        
        var unitTypes: [UnitViewModel.UnitType] { conversionType.unitTypes }
        var unitSelected: UnitViewModel.UnitType
                
        func resetValue(to new: Input) -> String? {
            guard
                unitSelected != new.unitSelected,
                value == new.value
            else { return nil }
            
            let unitString = convert(to: new)
            
            guard new.value != unitString else {
                return nil
            }
            
            return unitString
        }
        
        func convert(to input: Input) -> String {
            let value = Double(self.value) ?? 0
            let unit = Measurement(value: value, unit: unitSelected.unitLength)
            let unitConverted = unit.converted(to: input.unitSelected.unitLength)
            let unitString = String(format: "%.2f", unitConverted.value)
            return unitString
        }
    }
    
    struct ConversionType: Equatable, Hashable {
        var title: String
        var shortTitle: String
        var unitTypes: [UnitViewModel.UnitType]
    }
    
    struct UnitType: Equatable, Hashable {
        var title: String
        var shortTitle: String
        let unitLength: Dimension
    }
}

// MARK: All Cases

extension UnitViewModel.ConversionType {
    static var allCases: [UnitViewModel.ConversionType] { [.temperature, .length, .time, .volume] }
}

// MARK: Temperature

extension UnitViewModel.ConversionType {
    static let temperature = UnitViewModel.ConversionType(
        title: "Temperature",
        shortTitle: "Temp",
        unitTypes: [.celsius, .fahrenheit, .kelvin]
    )
}

extension UnitViewModel.UnitType {
    static let celsius = UnitViewModel.UnitType(
        title: "Celsius",
        shortTitle: "°C",
        unitLength: UnitTemperature.celsius
    )
    
    static let fahrenheit = UnitViewModel.UnitType(
        title: "Fahrenheit",
        shortTitle: "°F",
        unitLength: UnitTemperature.fahrenheit
    )
    
    static let kelvin = UnitViewModel.UnitType(
        title: "Kelvin",
        shortTitle: "K",
        unitLength: UnitTemperature.kelvin
    )

}

// MARK: Length

extension UnitViewModel.ConversionType {
    static let length = UnitViewModel.ConversionType(
        title: "Length",
        shortTitle: "Lgth",
        unitTypes: [.meters, .kilometers, .feet, .yards, .miles]
    )
}

extension UnitViewModel.UnitType {
    static let meters = UnitViewModel.UnitType(
        title: "Meters",
        shortTitle: "m",
        unitLength: UnitLength.meters
    )
    
    static let kilometers = UnitViewModel.UnitType(
        title: "Kilometers",
        shortTitle: "Km",
        unitLength: UnitLength.kilometers
    )
    
    static let feet = UnitViewModel.UnitType(
        title: "Feet",
        shortTitle: "ft",
        unitLength: UnitLength.feet
    )
    
    static let yards = UnitViewModel.UnitType(
        title: "Yards",
        shortTitle: "yd",
        unitLength: UnitLength.yards
    )
    
    static let miles = UnitViewModel.UnitType(
        title: "Miles",
        shortTitle: "mi",
        unitLength: UnitLength.miles
    )
}

// MARK: Time

extension UnitViewModel.ConversionType {
    static let time = UnitViewModel.ConversionType(
        title: "Time",
        shortTitle: "Time",
        unitTypes: [.seconds, .minutes, .hours, .days]
    )
}

extension UnitViewModel.UnitType {
    static let seconds = UnitViewModel.UnitType(
        title: "Seconds",
        shortTitle: "s",
        unitLength: UnitDuration.seconds
    )
    
    static let minutes = UnitViewModel.UnitType(
        title: "Minutes",
        shortTitle: "m",
        unitLength: UnitDuration.minutes
    )
    
    static let hours = UnitViewModel.UnitType(
        title: "Hours",
        shortTitle: "h",
        unitLength: UnitDuration.hours
    )
    
    static let days = UnitViewModel.UnitType(
        title: "Days",
        shortTitle: "d",
        unitLength: UnitDuration.hours
    )
}

// MARK: Time

extension UnitViewModel.ConversionType {
    static let volume = UnitViewModel.ConversionType(
        title: "Volume",
        shortTitle: "Vol",
        unitTypes: [.milliliters, .liters, .cups, .pints, .gallons]
    )
}

extension UnitViewModel.UnitType {
    static let milliliters = UnitViewModel.UnitType(
        title: "Milliliters",
        shortTitle: "ml",
        unitLength: UnitVolume.milliliters
    )
    
    static let liters = UnitViewModel.UnitType(
        title: "Liters",
        shortTitle: "l",
        unitLength: UnitVolume.liters
    )
    
    static let cups = UnitViewModel.UnitType(
        title: "Cups",
        shortTitle: "c",
        unitLength: UnitVolume.cups
    )
    
    static let pints = UnitViewModel.UnitType(
        title: "Pints",
        shortTitle: "pt",
        unitLength: UnitVolume.pints
    )
    
    static let gallons = UnitViewModel.UnitType(
        title: "Gallons",
        shortTitle: "gal",
        unitLength: UnitVolume.gallons
    )
}
