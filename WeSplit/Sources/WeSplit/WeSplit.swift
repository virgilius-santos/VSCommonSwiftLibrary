
import SwiftUI

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct ContentData {
    var checkAmount = ""
//    var numberOfPeople = 2
    var numberOfPeople: String = "2"
    var tipPercentage = 2
    var tipPercentages: [Int] = [10, 15, 20, 25, 0]
    
    var totalAmount: Double {
        let tipSelection = Double(tipPercentages[tipPercentage]) / 100
        let orderAmount = Double(checkAmount) ?? 0
        
        let tipAmount = orderAmount * tipSelection
        let totalAmount = tipAmount + orderAmount
        return totalAmount
    }
    
    var totalPerPerson: LocalizedStringKey {
        let peopleCount = Double(numberOfPeople) ?? 0
        let amountPerPerson = totalAmount / peopleCount
        
        return "$ \(amountPerPerson, specifier: "%.2f")"
    }
    
    var total: LocalizedStringKey {
        "$ \(totalAmount, specifier: "%.2f")"
    }
}

struct ContentView: View {
    
    @State private var content = ContentData()
    
    var body: some View {
        NavigationView {
            AmountForm(content: content)
        }
    }
}


struct AmountForm: View {
    
    @State var content: ContentData
    
    var body: some View {
        Form {
            Section {
                TextField("Amount", text: $content.checkAmount)
                    .keyboardType(.decimalPad)
                
                //                    Picker("Select number of people", selection: $content.numberOfPeople) {
                //                        ForEach(2 ..< 100) {
                //                            Text("\($0) people")
                //                        }
                //                    }
                
                TextField("Number of people", text: $content.numberOfPeople)
                    .keyboardType(.numberPad)
            }
            
            Section(header: Text("How much tip do you want to leave?")) {
                Picker("Tip percentage", selection: $content.tipPercentage) {
                    ForEach(0 ..< content.tipPercentages.count) {
                        Text("\(content.tipPercentages[$0])%")
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
            }
            
            Section(header: Text("Amount per person")) {
                Text(content.totalPerPerson)
            }
            
            Section(header: Text("Total Amount")) {
                Text(content.total)
            }
        }
        .navigationBarTitle("SwiftUI", displayMode: .inline)
    }
}
