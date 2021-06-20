
import SwiftUI
import ComposableArchitecture

struct BalanceList_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            BalanceList.View()
        }
    }
}

public enum BalanceList {}

public extension BalanceList {
    typealias Store = ComposableArchitecture.Store<State, Action>
    typealias Reducer = ComposableArchitecture.Reducer<State, Action, Environment>
    
    struct State: Equatable {

        var fixedInput: FixedInput.State?
        var inputNewFixedValue: Bool { fixedInput != nil }
        var fixedValues: [FixedValue] = [.init(id: .init()), .init(id: .init())] // []
        var fixedCard: CardBalance.State {
            .init(title: "Gastos Fixos", values: fixedValues.map(\.value))
        }
        
        var recurrenceInput: RecurrenceInput.State?
        var inputNewRecurrenceValue: Bool { recurrenceInput != nil }
        var recurrenceValues: [RecurrenceValue] = [.init(id: .init()), .init(id: .init())] // []
        var recurrenceCard: CardBalance.State {
            .init(title: "Gastos Recorrentes", values: recurrenceValues.map(\.pawn))
        }
    }
    
    enum Action: Equatable {
//        case appear
        case fixedViewVisualization(Bool)
        case fixedInput(FixedInput.Action)
        
        case recurrenceViewVisualization(Bool)
        case recurrenceInput(RecurrenceInput.Action)
    }
    
    struct Environment {
        var uuid: UUID
        var storage: BalanceLocalStorage
        
        public init(storage: BalanceLocalStorage = .init(), uuid: UUID = .init()) {
            self.storage = storage
            self.uuid = uuid
        }
    }
    
    static let reducer: Reducer = .combine(
        FixedInput.reducer
            .optional()
            .pullback(
                state: \.fixedInput,
                action: /BalanceList.Action.fixedInput,
                environment: { .init(storage: $0.storage) }
            )
            .combined(with: .init { state, action, environment in
                switch action {
                // FixedInput
                
                case .fixedViewVisualization(true):
                    state.fixedInput = .init(value: .init(id: environment.uuid), list: state.fixedValues)
                    return .none
                    
                case .fixedViewVisualization(false):
                    state.fixedInput = nil
                    return .none
                    
                case .fixedInput(.addValue):
                    guard let list = state.fixedInput?.list else { return .none }
                    state.fixedValues = list
                    state.fixedInput = nil
                    return .none
                    
                default:
                    return .none
                }
            })
        ,
        RecurrenceInput.reducer
            .optional()
            .pullback(
                state: \.recurrenceInput,
                action: /BalanceList.Action.recurrenceInput,
                environment: { .init(storage: $0.storage) }
            )
            .combined(with: .init { state, action, environment in
                switch action {
                // RecurrenceInput

                case .recurrenceViewVisualization(true):
                    state.recurrenceInput = .init(value: .init(id: environment.uuid), list: state.recurrenceValues)
                    return .none

                case .recurrenceViewVisualization(false):
                    state.recurrenceInput = nil
                    return .none

                case .recurrenceInput(.addValue):
                    guard let list = state.recurrenceInput?.list else { return .none }
                    state.recurrenceValues = list
                    state.recurrenceInput = nil
                    return .none

                default:
                    return .none
                }
            })
    )
    .debug()
    
    
    struct View: SwiftUI.View {
        public var body: some SwiftUI.View {
            WithViewStore(store) { viewStore in
                ZStack {
                    Color.offWhite.edgesIgnoringSafeArea(.all)
                    
                    NavigationLink(
                        destination: IfLetStore(
                            store.scope(
                                state: \.fixedInput,
                                action: BalanceList.Action.fixedInput
                            ),
                            then: { FixedInput.View(store: $0) }
                        ),
                        isActive: viewStore.binding(
                            get: \.inputNewFixedValue,
                            send: BalanceList.Action.fixedViewVisualization
                        ),
                        label: { EmptyView() }
                    )
                    
//                    NavigationLink(
//                        destination: IfLetStore(
//                            store.scope(
//                                state: \.recurrenceInput,
//                                action: BalanceList.Action.recurrenceInput
//                            ),
//                            then: { RecurrenceInput.View(store: $0) }
//                        ),
//                        isActive: viewStore.binding(
//                            get: \.inputNewRecurrenceValue,
//                            send: BalanceList.Action.recurrenceViewVisualization
//                        ),
//                        label: { EmptyView() }
//                    )
                    
                    ScrollView {
                        LazyVStack.init(alignment: .center, spacing: .spacing_10) {
                            CardBalance.View(
                                state: viewStore.fixedCard,
                                action: { viewStore.send(.fixedViewVisualization(true)) }
                            )
                            
                            CardBalance.View(
                                state: viewStore.recurrenceCard,
                                action: { viewStore.send(.recurrenceViewVisualization(true)) }
                            )
                        }
                    }
                }
                .onAppear {
//                    viewStore.send(.appear)
                }
            }
        }
        
        let store: Store
        
        public init() {
            store = .init(
                initialState: .init(),
                reducer: BalanceList.reducer,
                environment: .init()
            )
        }
    }
    
}
