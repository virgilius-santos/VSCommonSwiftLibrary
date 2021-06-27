
import ComposableArchitecture
import SwiftUI

struct FixedInputView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            FixedInput.View(store: .init(initialState: .init(value: .init(id: .init())), reducer: FixedInput.reducer, environment: .init(addValue: { _ in })))
        }
    }
}

public enum FixedInput {}

public extension FixedInput {
    typealias Store = ComposableArchitecture.Store<State, Action>
    typealias Reducer = ComposableArchitecture.Reducer<State, Action, Environment>
    
    struct State: Equatable {
        var value: FixedValue
        
        init(value: FixedValue) {
            self.value = value
        }
    }

    enum Action: Equatable {
        case addValue
        case form(BindingAction<State>)
    }

    struct Environment {
        var addValue: (FixedValue) -> Void
        
        public init(addValue: @escaping (FixedValue) -> Void) {
            self.addValue = addValue
        }
    }
    
    static let reducer: Reducer = .init { state, action, environment in
        switch action {
        case .addValue:
            environment.addValue(state.value)
            return .none
            
        case .form:
            return .none
        }
    }
    .binding(action: /FixedInput.Action.form)
    
    struct View: SwiftUI.View {
        
        public var body: some SwiftUI.View {
            WithViewStore(store) { viewStore in
                ZStack(alignment: .center) {
                    Form {
                        Section(header: Text("Fixed Invoice")) {
                            TextField(
                                "Description",
                                text: viewStore.binding(
                                    keyPath: \.value.desc,
                                    send: FixedInput.Action.form
                                )
                            )
                            
                            TextField.init(
                                "Value",
                                value: viewStore.binding(
                                    keyPath: \.value.value,
                                    send: FixedInput.Action.form
                                ),
                                formatter: decimalFormatter
                            )
                            .keyboardType(.numbersAndPunctuation)
                            
                            Picker(
                                "Due date",
                                selection: viewStore.binding(
                                    keyPath: \.value.day.selected,
                                    send: FixedInput.Action.form
                                )
                            ) {
                                ForEach(viewStore.value.day.availables, id: \.self) {
                                    Text("\($0)")
                                }
                            }
                            
                            Picker(
                                "Payment source",
                                selection: viewStore.binding(
                                    keyPath: \.value.source.selected,
                                    send: FixedInput.Action.form
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
                            )
                            .padding()
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
