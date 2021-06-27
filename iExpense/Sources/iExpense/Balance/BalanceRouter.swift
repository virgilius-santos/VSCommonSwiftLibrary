
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
        var balanceList: BalanceList.State = .init()
        
        var fixedState: FixedInput.State?
//        var showFixed: Bool = false
        
        var recurrenceState: RecurrenceInput.State?
//        var showRecurrence: Bool = false
        
        var navigate: Bool { fixedState != nil || recurrenceState != nil }
    }
    
    enum Action: Equatable {
        case didAppear
        case listAction(BalanceList.Action)
        
//        case fixedActionVisibility(Bool)
        case fixedActions(FixedInput.Action)
        
//        case recurrenceActionVisibility(Bool)
        case recurrenceActions(RecurrenceInput.Action)
        
        case navigationStatus(Bool)
    }
    
    struct Environment {
        var uuid: () -> UUID = UUID.init
        var storage: BalanceLocalStorage = .init()
    }
    
    static let reducer: Reducer = .combine(
        FixedInput.reducer
            .optional()
            .pullback(
                state: \.fixedState,
                action: /BalanceRouter.Action.fixedActions,
                environment: {
                    .init(addValue: $0.storage.addFixedValue)
                }
            ),
        
        RecurrenceInput.reducer
            .optional()
            .pullback(
                state: \.recurrenceState,
                action: /BalanceRouter.Action.recurrenceActions,
                environment: {
                    .init(addValue: $0.storage.addRecurrentValue)
                }
            )
    )
    .combined(with: BalanceList.reducer.pullback(
        state: \.balanceList,
        action: /BalanceRouter.Action.listAction,
        environment: {
            .init(
                fixedValues: $0.storage.getFixedValues,
                recurrenceValues: $0.storage.getRecurrentValues
            )
        }
    ))
    .combined(with: .init { state, action, env in
        switch action {
        case .listAction(.showFixedView):
            state.fixedState = .init(value: .init(id: env.uuid()))
            return .none
            
        case .fixedActions(.addValue):
            state.fixedState = nil
            return .none
            
        case .listAction(.showRecurrenceView):
            state.recurrenceState = .init(value: .init(id: env.uuid()))
            return .none
            
        case .recurrenceActions(.addValue):
            state.recurrenceState = nil
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
//                    if viewStore.fixedState != nil {
//                        NavigationLink.init(
//                            destination: IfLetStore(
//                                store.scope(state: \.fixedState, action: BalanceRouter.Action.fixedActions),
//                                then: FixedInput.View.init(store:)
//                            ),
//                            isActive: viewStore.binding(
//                                get: \.showFixed,
//                                send: BalanceRouter.Action.fixedActionVisibility
//                            ),
//                            label: EmptyView.init
//                        )
//                    }
//
//                    if viewStore.recurrenceState != nil {
//                        NavigationLink.init(
//                            destination: IfLetStore(
//                                store.scope(state: \.recurrenceState, action: BalanceRouter.Action.recurrenceActions),
//                                then: RecurrenceInput.View.init(store:)
//                            ),
//                            isActive: viewStore.binding(
//                                get: \.showRecurrence,
//                                send: BalanceRouter.Action.recurrenceActionVisibility
//                            ),
//                            label: EmptyView.init
//                        )
//                    }
                    
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
