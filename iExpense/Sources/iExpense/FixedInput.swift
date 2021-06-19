
import ComposableArchitecture
import SwiftUI

struct FixedInputView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            FixedInput.View(store: .init(
                initialState: .init(),
                reducer: FixedInput.reducer,
                environment: .init()
            ))
        }
    }
}

public enum FixedInput {}

public extension FixedInput {
    typealias Store = ComposableArchitecture.Store<State, Action>
    typealias Reducer = ComposableArchitecture.Reducer<State, Action, Environment>
    
    struct State: Equatable, Hashable {
        
        var modelList: [FixedValue]
        var model: FixedValue
        
        init(
            modelList: [FixedValue] = [.init(), .init()],
            model: FixedValue = .init()
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
                                    keyPath: \.model.desc,
                                    send: FixedInput.Action.form
                                )
                            )
                            
                            TextField.init(
                                "Value",
                                value: viewStore.binding(
                                    keyPath: \.model.value,
                                    send: FixedInput.Action.form
                                ),
                                formatter: decimalFormatter
                            )
                            .keyboardType(.numbersAndPunctuation)
                            
                            Picker(
                                "Due date",
                                selection: viewStore.binding(
                                    keyPath: \.model.day.selected,
                                    send: FixedInput.Action.form
                                )
                            ) {
                                ForEach(viewStore.model.day.availables, id: \.self) {
                                    Text("\($0)")
                                }
                            }
                            
                            Picker(
                                "Payment source",
                                selection: viewStore.binding(
                                    keyPath: \.model.source.selected,
                                    send: FixedInput.Action.form
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
