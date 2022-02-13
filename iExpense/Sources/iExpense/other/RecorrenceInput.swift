
import ComposableArchitecture
import SwiftUI

//struct RecurrenceInputView_Previews: PreviewProvider {
//  static var previews: some View {
//    NavigationView {
//      RecurrenceInput.View(store: .init(
//        initialState: .init(value: .init(id: .init()), list: [.init(id: .init()), .init(id: .init())]),
//        reducer: RecurrenceInput.reducer,
//        environment: .init(storage: .init())
//      ))
//    }
//  }
//}

public enum RecurrenceInput {}

public extension RecurrenceInput {
  typealias Store = ComposableArchitecture.Store<State, Action>
  typealias Reducer = ComposableArchitecture.Reducer<State, Action, Environment>
  
  struct State: Equatable {
    var value: RecurrenceValue
    var values: [RecurrenceValue]
    init(value: RecurrenceValue, values: [RecurrenceValue]) {
      self.value = value
      self.values = values
    }
  }
  
  enum Action: Equatable {
    case addValue
    case form(BindingAction<State>)
  }
  
  struct Environment {}
  
  static let reducer: Reducer = .init { state, action, _ in
    switch action {
    case .addValue:
      state.values.append(state.value)
      return .none
      
    case .form:
      return .none
    }
  }
    .binding(action: /RecurrenceInput.Action.form).debug()
  
  struct View: SwiftUI.View {
    
    public var body: some SwiftUI.View {
      WithViewStore(store) { viewStore in
        ZStack(alignment: .center) {
          Form {
            Section(header: Text("Recurrence Invoice")) {
              TextField(
                "Description",
                text: viewStore.binding(
                  keyPath: \.value.desc,
                  send: RecurrenceInput.Action.form
                )
              )
              
              TextField.init(
                "Value",
                value: viewStore.binding(
                  keyPath: \.value.value,
                  send: RecurrenceInput.Action.form
                ),
                formatter: decimalFormatter
              )
                .keyboardType(.numbersAndPunctuation)
              
              Picker(
                "Current installment",
                selection: viewStore.binding(
                  keyPath: \.value.current,
                  send: RecurrenceInput.Action.form
                )
              ) {
                ForEach(1..<viewStore.value.total, id: \.self) {
                  Text("\($0)")
                }
              }
              
              Picker(
                "number of installments",
                selection: viewStore.binding(
                  keyPath: \.value.total,
                  send: RecurrenceInput.Action.form
                )
              ) {
                ForEach(2..<UInt8.max, id: \.self) {
                  Text("\($0)")
                }
              }
              
              Picker(
                "Payment source",
                selection: viewStore.binding(
                  keyPath: \.value.source.selected,
                  send: RecurrenceInput.Action.form
                )
              ) {
                ForEach(viewStore.value.source.availables, id: \.self) {
                  Text("\($0)")
                }
              }
            }
            
          }
          VStack {
            Spacer()
            HStack {
              Spacer()
              FloatingButton(
                iconName: "plus.circle.fill",
                action: { viewStore.send(.addValue) }
              ).padding()
            }
          }
          
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("Inputs")
      }
    }
    
    let store: Store
    
    public init(store: Store) {
      self.store = store
    }
  }
}
