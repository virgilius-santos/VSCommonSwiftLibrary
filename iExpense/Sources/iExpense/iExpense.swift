
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

enum App {
    typealias Store = ComposableArchitecture.Store<State, Action>
    typealias Reducer = ComposableArchitecture.Reducer<State, Action, Environment>
    
    struct State: Equatable {
        
        var first: First.State?
        var second: Second.State?
        
        var navigate: Bool { first != nil || second != nil }
    }
    
    enum Action: Equatable {
        case first(First.Action)
        case second(Second.Action)
        case showF, showS
        
        case navigationStatus(Bool)
    }
    
    struct Environment {}
    
    static let reducer: Reducer = .combine(
        First.reducer
            .optional()
            .pullback(
                state: \.first,
                action: /App.Action.first,
                environment: { _ in First.Environment() }
            ),
        Second.reducer
            .optional()
            .pullback(
                state: \.second,
                action: /App.Action.second,
                environment: { _ in Second.Environment() }
            )
    )
    .combined(with: .init { state, action, environment in
        switch action {
        
        case .first:
            return .none
            
        case .second:
            return .none
            
        case .showF:
            state.first = .init()
            return .none
            
        case .showS:
            state.second = .init()
            return .none
            
        case .navigationStatus(true):
            return .none
            
        case .navigationStatus(false):
            if state.first != nil { state.first = nil }
            if state.second != nil { state.second = nil }
            return .none
        }
    })
    
    struct View: SwiftUI.View {
        
        let store: Store
        
        var body: some SwiftUI.View {
            WithViewStore(store) { viewStore in
                
                VStack {
                    NavigationLink(
                        destination: IfLetStore.init(
                            store.scope(
                                state: \.first,
                                action: App.Action.first
                            ),
                            then: First.View.init(store:),
                            else: {
                                IfLetStore.init(
                                    store.scope(
                                        state: \.second,
                                        action: App.Action.second
                                    ),
                                    then: Second.View.init(store:)
                                )
                            }
                        ),
                        isActive: viewStore.binding(
                            get: \.navigate,
                            send: App.Action.navigationStatus
                        ),
                        label: EmptyView.init
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
