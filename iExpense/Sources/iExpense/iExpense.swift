
import ComposableArchitecture
import SwiftUI

struct AppContentView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            App.View(store: .init(
                initialState: .init(),
                reducer: App.reducer,
                environment: App.Environment()
            ))
        }
    }
}

enum NavExample {}

extension NavExample {
    enum State: Equatable {
        case first(First.State)
        case second(Second.State)
        case none
        
        var navigate: Bool { self != .none }
    }

    enum Action: Equatable {
        case first(First.Action)
        case second(Second.Action)
        case navigationStatus(Bool)
    }

    struct Env {}
    
    static let reducer: Reducer<State, Action, Env> = .combine(
        First.reducer
            .pullback(
                state: /State.first,
                action: /Action.first,
                environment: { _ in .init() }
            ),
        
        Second.reducer
            .pullback(
                state: /State.second,
                action: /Action.second,
                environment: { _ in .init() }
            )
    )
    
    struct View: SwiftUI.View {
        
        let store: Store<State, Action>
        
        var body: some SwiftUI.View {
            WithViewStore.init(store, content: { viewStore in
                NavigationLink.lazy(
                    isActive: viewStore.binding(
                        get: \.navigate,
                        send: NavExample.Action.navigationStatus
                    )
                ) {
                    switch viewStore.state {
                    case .first(let state):
                        First.View.init(store: store.scope(
                            state: { _ in state },
                            action: NavExample.Action.first
                        ))
                    case .second(let state):
                        Second.View.init(store: store.scope(
                            state: { _ in state },
                            action: NavExample.Action.second
                        ))
                    case .none:
                        EmptyView()
                    }
                }
            })
        }
    }
}

enum App {
    typealias Store = ComposableArchitecture.Store<State, Action>
    typealias Reducer = ComposableArchitecture.Reducer<State, Action, Environment>
    
    struct State: Equatable {
        var nav: NavExample.State = .none
    }
    
    enum Action: Equatable {
        case showF, showS
        
        case nav(NavExample.Action)
    }
    
    struct Environment {}
    
    static let reducer: Reducer = NavExample.reducer
        .pullback(
            state: \.nav,
            action: /App.Action.nav,
            environment: { _ in .init() }
        )
        .combined(with: .init { state, action, environment in
            switch action {
            
            case .showF:
                state.nav = .first(.init())
                return .none
                
            case .showS:
                state.nav = .second(.init())
                return .none
                
            case .nav(.navigationStatus(false)):
                state.nav = .none
                return .none
                
            default:
                return .none
            }
        })
    
    struct View: SwiftUI.View {
        
        let store: Store
        
        var body: some SwiftUI.View {
            WithViewStore(store) { viewStore in
                
                VStack {
                    NavExample.View.init(
                        store: store.scope(
                            state: \.nav,
                            action: App.Action.nav
                        )
                    )
                    
                    Button("First", action: { viewStore.send(.showF) })
                    
                    Button("Second", action: { viewStore.send(.showS) })
                }
            }
        }
    }
}

enum First {
    typealias Store = ComposableArchitecture.Store<State, Action>
    typealias Reducer = ComposableArchitecture.Reducer<State, Action, Environment>
    
    struct State: Equatable {
        
        var current: Int = 2
        
        init(current: Int = 2) {
            self.current = current
        }
    }
    
    enum Action: Equatable {
        case form(BindingAction<State>)
    }
    
    struct Environment {}
    
    static let reducer: Reducer = .init { state, action, environment in
        return .none
    }
    .binding(action: /First.Action.form)
    
    struct View: SwiftUI.View {
        
        let store: Store
        
        var body: some SwiftUI.View {
            WithViewStore(store) { viewStore in
                Form {
                    Picker(
                        "Current installment",
                        selection: viewStore.binding(
                            keyPath: \.current,
                            send: First.Action.form
                        )
                    ) {
                        ForEach(1..<10, id: \.self) {
                            Text("\($0)")
                        }
                    }
                }
            }
        }
    }
}


enum Second {
    typealias Store = ComposableArchitecture.Store<State, Action>
    typealias Reducer = ComposableArchitecture.Reducer<State, Action, Environment>
    
    struct State: Equatable {
        
        var current: Int = 2
        
        init(current: Int = 2) {
            self.current = current
        }
    }
    
    enum Action: Equatable {
        case form(BindingAction<State>)
    }
    
    struct Environment {}
    
    static let reducer: Reducer = .init { state, action, environment in
        return .none
    }
    .binding(action: /Second.Action.form)
    
    struct View: SwiftUI.View {
        
        let store: Store
        
        var body: some SwiftUI.View {
            WithViewStore(store) { viewStore in
                Form {
                    Picker(
                        "Current installment",
                        selection: viewStore.binding(
                            keyPath: \.current,
                            send: Second.Action.form
                        )
                    ) {
                        ForEach(1..<10, id: \.self) {
                            Text("\($0)")
                        }
                    }
                }
            }
        }
    }
}
