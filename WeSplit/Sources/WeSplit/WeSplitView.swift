
import SwiftUI

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        WeSplitView()
    }
}

struct WeSplitView: View {
    
    @State private var content = WeSplitViewModel()
    
    var body: some View {
        NavigationView {
            AmountForm(content: content)
        }
    }
}

struct AmountForm: View {
    
    @State var content: WeSplitViewModel
    
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
                Text(content.total).foregroundColor(content.tipPercentage == 4 ? .red : .black)
            }
        }
        .navigationBarTitle("SwiftUI", displayMode: .inline)
    }
}
