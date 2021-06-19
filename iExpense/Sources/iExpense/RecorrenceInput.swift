
import ComposableArchitecture
import SwiftUI

struct RecorrenceInputView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            RecorrenceInput.View(store: .init(
                initialState: .init(),
                reducer: RecorrenceInput.reducer,
                environment: .init()
            ))
        }
    }
}

public enum RecorrenceInput {}

public extension RecorrenceInput {
    typealias Store = ComposableArchitecture.Store<State, Action>
    typealias Reducer = ComposableArchitecture.Reducer<State, Action, Environment>
    
    struct State: Equatable, Hashable {
        
        var modelList: [RecorrenceValue]
        var model: RecorrenceValue
        
        init(
            modelList: [RecorrenceValue] = [.init(), .init()],
            model: RecorrenceValue = .init()
        ) {
            self.modelList = modelList
            self.model = model
        }
    }

    enum Action: Equatable {
        case addValue
        case form(BindingAction<State>)
    }

    struct Environment: Equatable, Hashable {
        public init() {}
    }
    
    static let reducer: Reducer = .combine(
        .init { state, action, environment in
            switch action {
            case .addValue:
                state.modelList.append(state.model)
                return .none
            case .form:
                return .none
            }
        }
    )
    .binding(action: /RecorrenceInput.Action.form)
    
    struct View: SwiftUI.View {
        
        public var body: some SwiftUI.View {
            WithViewStore(store) { viewStore in
                ZStack(alignment: .center) {
                    Form {
                        Section(header: Text("Recorrence Invoice")) {
                            TextField(
                                "Description",
                                text: viewStore.binding(
                                    keyPath: \.model.desc,
                                    send: RecorrenceInput.Action.form
                                )
                            )
                            
                            TextField.init(
                                "Value",
                                value: viewStore.binding(
                                    keyPath: \.model.value,
                                    send: RecorrenceInput.Action.form
                                ),
                                formatter: decimalFormatter
                            )
                            .keyboardType(.numbersAndPunctuation)
                            
                            DatePicker.init(
                                selection: viewStore.binding(
                                    keyPath: \.model.startDate,
                                    send: RecorrenceInput.Action.form
                                ),
                                displayedComponents: .date,
                                label: { Text("Bought in")}
                            )
                            .datePickerStyle(CompactDatePickerStyle())
                            .frame(maxHeight: 400)
                            
                            Picker(
                                "number of installments",
                                selection: viewStore.binding(
                                    keyPath: \.model.installments,
                                    send: RecorrenceInput.Action.form
                                )
                            ) {
                                ForEach(2..<UInt8.max, id: \.self) {
                                    Text("\($0)")
                                }
                            }
                            
                            Picker(
                                "Payment source",
                                selection: viewStore.binding(
                                    keyPath: \.model.source.selected,
                                    send: RecorrenceInput.Action.form
                                )
                            ) {
                                ForEach(viewStore.model.source.availables, id: \.self) {
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
