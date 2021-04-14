
import SwiftUI
import CoreML

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        BettterRestView()
    }
}

public struct BettterRestView: View {
    
    @State var viewModel = BettterRestModel()
            
    public init() {}
    
    public var body: some View {
        NavigationView {
            Form {
                Section(
                    header: Text("When do you want to wake up?")
                ) {
                    
                    DatePicker(
                        "Please enter a time",
                        selection: $viewModel.wakeUp,
                        displayedComponents: .hourAndMinute
                    )
                }
                
                Section(
                    header: Text("Desired amount of sleep")
                ) {

                    Stepper(value: $viewModel.sleepAmount, in: 4...12, step: 0.25) {
                        Text("\(viewModel.sleepAmount, specifier: "%g") hours")
                    }
                }
                
                Section(
                    header: Text("Daily coffee intake")
                ) {
                    
//                    Stepper(value: $viewModel.coffeeAmount, in: 1...20) {
//                        if viewModel.coffeeAmount == 1 {
//                            Text("1 cup")
//                        } else {
//                            Text("\(viewModel.coffeeAmount) cups")
//                        }
//                    }
                    Picker("Daily coffee intake", selection: $viewModel.coffeeAmount) {
                        ForEach(1 ..< 21) { index in
                            if index == 1 {
                                Text("1 cup")
                            } else {
                                Text("\(index) cups")
                            }
                        }
                    }
                }
                
                Section {
                    let message = calculateBedtime()
                    Text(message.title)
                    Text(message.message).font(.largeTitle)
                }
            }
            .navigationBarTitle(Text("BetterRest"))
        }
    }
    
    func calculateBedtime() -> AlertMessage {
        
        do {
            let model = Current.model
            
            let sleepTime = try model.sleepTimePrediction(viewModel)
            
            return .init(
                title: "Your ideal bedtime is…",
                message: sleepTime.string
            )
        } catch {
            // something went wrong!
            return .init(
                title: "Error",
                message: "Sorry, there was a problem calculating your bedtime."
            )
        }
    }
}

struct AlertMessage {
    var title = ""
    var message = ""
}


public struct BettterRestModel {
    var wakeUp = Date.defaultWakeTime
    var sleepAmount = 8.0
    var coffeeAmount = 1
}

extension SleepCalculatorModel {
    static let live: SleepCalculatorModel = .init { (bettterRestModel) -> Date in
        let model = try SleepCalculator(configuration: MLModelConfiguration())
        
        let (hour, minute) = bettterRestModel.wakeUp.hourMinuteComponents
        
        let prediction = try model.prediction(
            wake: Double(hour + minute),
            estimatedSleep: bettterRestModel.sleepAmount,
            coffee: Double(bettterRestModel.coffeeAmount)
        )
        return bettterRestModel.wakeUp - prediction.actualSleep
    }
    
    static let failure: SleepCalculatorModel = .init { _ in throw NSError(domain: "", code: -1, userInfo: nil) }
}

struct SleepCalculatorModel {
    var sleepTimePrediction: (BettterRestModel) throws -> Date
}

struct BetterRestEnvironment {
    var date: () -> Date = Date.init
    let model = SleepCalculatorModel.live
    let calendar: () -> Calendar = { Calendar.current }
}

var Current = BetterRestEnvironment()

extension Date {
    var hourMinuteComponents: (hour: Int, minute: Int) {
        let components = Current.calendar().dateComponents([.hour, .minute], from: self)
        let hour = (components.hour ?? 0) * 60 * 60
        let minute = (components.minute ?? 0) * 60
        return (hour, minute)
    }
    
    var string: String {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        return formatter.string(from: self)
    }
    
    static var defaultWakeTime: Date {
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        return Current.calendar().date(from: components) ?? Date()
    }
}
