
import SwiftUI
import ComposableArchitecture
import Combine
import Styles

struct BalanceRouter_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            BalanceRouter.View(store: .init(
                initialState: .init(),
                reducer: BalanceRouter.reducer,
                environment: .init()
            ))
        }
    }
}

public enum BalanceRouter {}

public extension BalanceRouter {
    typealias Store = ComposableArchitecture.Store<State, Action>
    typealias Reducer = ComposableArchitecture.Reducer<State, Action, Environment>
    
    struct State: Equatable {
        var fixedValues: [FixedValue] = []
        var recurrenceValues: [RecurrenceValue] = []
        
        var balanceList: BalanceList.State {
            get { .init(fixedValues: fixedValues) }
            set {
                fixedValues = newValue.fixedInput.values
                recurrenceValues = newValue.recurrenceInput.values
            }
        }
        
        var fixedState: FixedInput.State?
        var recurrenceState: RecurrenceInput.State?
        
        var navigate: Bool { fixedState != nil || recurrenceState != nil }
    }
    
    enum Action: Equatable {
        case didAppear
        case listAction(BalanceList.Action)
        
        case fixedActions(FixedInput.Action)
        case recurrenceActions(RecurrenceInput.Action)
        
        case navigationStatus(Bool)
    }
    
    struct Environment {
        var uuid: () -> UUID = UUID.init
    }
    
    static let reducer: Reducer = .combine(
        FixedInput.reducer
            .optional()
            .pullback(
                state: \.fixedState,
                action: /BalanceRouter.Action.fixedActions,
                environment: { _ in .init() }
            ),
        
        RecurrenceInput.reducer
            .optional()
            .pullback(
                state: \.recurrenceState,
                action: /BalanceRouter.Action.recurrenceActions,
                environment: { _ in .init() }
            )
    )
    .combined(with: BalanceList.reducer.pullback(
        state: \.balanceList,
        action: /BalanceRouter.Action.listAction,
        environment: { _ in .init() }
    ))
    .combined(with: .init { state, action, env in
        switch action {
        case .listAction(.showFixedView):
            state.fixedState = .init(
                value: .init(id: env.uuid()),
                values: state.fixedValues
            )
            return .none
            
        case .fixedActions(.addValue):
            state.fixedValues = state.fixedState?.values ?? []
            state.fixedState = nil
            return .none
            
        case .listAction(.showRecurrenceView):
            state.recurrenceState = .init(
                value: .init(id: env.uuid()),
                values: state.recurrenceValues
            )
            return .none
            
        case .recurrenceActions(.addValue):
            state.recurrenceValues = state.recurrenceState?.values ?? []
            state.recurrenceState = nil
            return .none
            
        case .navigationStatus(false):
            if state.fixedState != nil { state.fixedState = nil }
            if state.recurrenceState != nil { state.recurrenceState = nil }
            return .none
            
        default:
            return .none
        }
    })
    
    struct View: SwiftUI.View {
        
        public var body: some SwiftUI.View {
            ZStack {
                
                WithViewStore(store) { viewStore in
                    
                    NavigationLink.lazy(
                        destination: IfLetStore(
                            store.scope(
                                state: \.fixedState,
                                action: BalanceRouter.Action.fixedActions
                            ),
                            then: FixedInput.View.init(store:),
                            else: {
                                IfLetStore(
                                    store.scope(
                                        state: \.recurrenceState,
                                        action: BalanceRouter.Action.recurrenceActions
                                    ),
                                    then: RecurrenceInput.View.init(store:)
                                )
                            }
                        ),
                        isActive: viewStore.binding(
                            get: \.navigate,
                            send: BalanceRouter.Action.navigationStatus
                        )
                    )
                    
                    BalanceList.View(store: store.scope(
                        state: \.balanceList,
                        action: BalanceRouter.Action.listAction
                    ))
                    .onAppear(perform: {
                        viewStore.send(.didAppear)
                    })
                }
            }
        }
        
        let store: Store
        
        init(store: BalanceRouter.Store) {
            self.store = store
        }
        
        public init() {
            self.init(store: .init(
                initialState: .init(),
                reducer: BalanceRouter.reducer,
                environment: .init()
            ))
        }
    }
}
