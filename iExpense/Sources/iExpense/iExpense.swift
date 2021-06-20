
import SwiftUI
//
//private struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        NavigationView {
//            IExpensiveView()
//        }
//    }
//}
//
//
//
//
//
//
//
//public struct IExpensiveView: View {
//    
//    public enum RecurrenceType: String, CaseIterable, Equatable {
//        case fixed
//    }
//    
//    @State
//    private var recurrenceType: RecurrenceType = .fixed
//    
//    @State
//    private var values: [InvoiceEntry & InvoiceID] = [FixedInput()]
//    
//    private let recurrences: [RecurrenceType] = RecurrenceType.allCases
//    
//    public var body: some View {
//        ZStack(alignment: .top) {
//            Form {
//                Section(header: Text("Recurrence Type")) {
//                    Picker("Recurrence Type", selection: $recurrenceType) {
//                        ForEach(recurrences, id: \.self) {
//                            Text($0.rawValue)
//                        }
//                    }
//                    .labelsHidden()
//                    .pickerStyle(SegmentedPickerStyle())
//                }
//                
//                switch recurrenceType {
//                case .fixed:
//                    fixedInput
//                }
//                
//                Section(header: Text("Lista")) {
//                    list
//                }
//            }
//            
//            VStack {
//                Spacer()
//                HStack {
//                    Spacer()
//                    floatingButton
//                }
//            }
//        }
//        .navigationBarTitleDisplayMode(.inline)
//        .navigationTitle("Inputs")
//    }
//
//    var list: some View {
//        List {
//            ForEach(values, id: \.id) {
//                Text($0.invoiceDescription)
//            }
//        }
//    }
//    
//    public struct Source {
//        var selected: String = "Nubank"
//        
//        let availables: [String] = ["Nubank", "Itau", "Way 9400", "Way 9880", "original"]
//    }
//    
//    public struct Day {
//        var selected: UInt8 = 10
//        let availables: [UInt8] = Array(1...30)
//    }
//    
//    public struct FixedInput: InvoiceID {
//        
//        public var id: String { UUID().uuidString }
//        
//        var descInputed: String = "Aluguel"
//        var valueInputed: String = "R$ 2000.00"
//        var day = Day()
//        var source = Source()
//        let recurrenceType: RecurrenceType = .fixed
//    }
//    
//    @State
//    private var fixedInputState: FixedInput = .init()
//    
//    var fixedInput: some View {
//        Section(header: Text("Fixed Invoice")) {
//            TextField("Description", text: $fixedInputState.descInputed)
//            
//            TextField("Value", text: $fixedInputState.valueInputed)
//                .keyboardType(.decimalPad)
//            
//            Picker("Due date", selection: $fixedInputState.day.selected) {
//                ForEach(fixedInputState.day.availables, id: \.self) {
//                    Text("\($0)")
//                }
//            }
//            
//            Picker("Payment source", selection: $fixedInputState.source.selected) {
//                ForEach(fixedInputState.source.availables, id: \.self) {
//                    Text("\($0)")
//                }
//            }
//        }
//    }
//    
//    var floatingButton: some View {
//        Button("Ok", action: { values.append(FixedInput()) })
//            .frame(width: 40, height: 40)
//            .padding(40)
//    }
//    
//    public init() {}
//}
//
//public protocol InvoiceEntry {
//    var invoiceDescription: String { get }
//}
//
//public protocol InvoiceID {
//    var id: String { get }
//}
//
//extension IExpensiveView.FixedInput: InvoiceEntry {
//    public var invoiceDescription: String {
//        "\(descInputed), due in: \(day.selected) \(valueInputed)"
//    }
//}
