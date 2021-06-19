
import SwiftUI
import ComposableArchitecture

struct BalanceList_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            BalanceList.View(
                store: .init(
                    initialState: .init(),
                    reducer: BalanceList.reducer,
                    environment: .init()
                )
            )
        }
    }
}

public enum BalanceList {}

public extension BalanceList {
    typealias Store = ComposableArchitecture.Store<State, Action>
    typealias Reducer = ComposableArchitecture.Reducer<State, Action, Environment>
    
    struct State: Equatable {

        var inputNewFixedValue = false
        var inputNewRecorrenceValue = false
        
        var fixedCard: CardBalance.State {
            .init(
                title: "Gastos Fixos",
                values: fixedInput.modelList.map(\.value)
            )
        }
        
        var recurrenceCard: CardBalance.State {
            .init(
                title: "Gastos Recorrentes",
                values: recorrenceInput.modelList.map(\.pawn)
            )
        }
        
        var fixedInput: FixedInput.State = .init()
        var recorrenceInput: RecorrenceInput.State = .init()
    }
    
    enum Action: Equatable {
        case appear
        case addFixedValue
        case addRecorrenceValue
        case showInputValue
        case hiddenInputValue
        case fixedInput(FixedInput.Action)
        case recorrenceInput(RecorrenceInput.Action)
    }
    
    struct Environment {}
    
    static let reducer: Reducer = .combine(
        
        FixedInput.reducer.pullback(
            state: \.fixedInput,
            action: /BalanceList.Action.fixedInput,
            environment: { _ in .init() }
        ),
        
        RecorrenceInput.reducer.pullback(
            state: \.recorrenceInput,
            action: /BalanceList.Action.recorrenceInput,
            environment: { _ in .init() }
        ),
        
        .init { state, action, environment in
            switch action {
            case .appear:
                return .none
                
            case .addFixedValue:
                state.inputNewFixedValue = true
                return .none
                
            case .addRecorrenceValue:
                state.inputNewRecorrenceValue = true
                return .none
                
            case .showInputValue:
                return .none
                
            case .hiddenInputValue:
                state.inputNewFixedValue = false
                state.inputNewRecorrenceValue = false
                return .none
                
            // FixedInput
            
            case .fixedInput(.addValue):
                state.inputNewFixedValue = false
                return .none
                
            case .fixedInput:
                return .none
                
            // RecorrenceInput
            
            case .recorrenceInput(.addValue):
                state.inputNewRecorrenceValue = false
                return .none
                
            case .recorrenceInput:
                return .none
            }
        }
    )
    
    
    struct View: SwiftUI.View {
        public var body: some SwiftUI.View {
            WithViewStore(store) { viewStore in
                ZStack {
                    Color.offWhite.edgesIgnoringSafeArea(.all)
                    
                    NavigationLink(
                        destination: FixedInput.View.init(
                            store: store.scope(
                                state: \.fixedInput,
                                action: BalanceList.Action.fixedInput
                            )
                        ),
                        isActive: viewStore.binding(
                            get: \.inputNewFixedValue,
                            send: { $0 ? .showInputValue : .hiddenInputValue }
                        ),
                        label: { EmptyView() }
                    )
                    
                    NavigationLink(
                        destination: RecorrenceInput.View.init(
                            store: store.scope(
                                state: \.recorrenceInput,
                                action: BalanceList.Action.recorrenceInput
                            )
                        ),
                        isActive: viewStore.binding(
                            get: \.inputNewRecorrenceValue,
                            send: { $0 ? .showInputValue : .hiddenInputValue }
                        ),
                        label: { EmptyView() }
                    )
                    
                    ScrollView {
                        LazyVStack.init(alignment: .center, spacing: .spacing_10) {
                            CardBalance.View(
                                state: viewStore.fixedCard,
                                action: { viewStore.send(.addFixedValue) }
                            )
                            
                            CardBalance.View(
                                state: viewStore.recurrenceCard,
                                action: { viewStore.send(.addRecorrenceValue) }
                            )
                        }
                    }
                }
                .onAppear {
                    viewStore.send(.appear)
                }
            }
        }
        
        let store: Store
    }
    
}
