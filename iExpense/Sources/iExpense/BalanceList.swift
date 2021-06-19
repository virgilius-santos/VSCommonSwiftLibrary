
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
    
    struct State: Equatable, Hashable {
        var fixedValues: [FixedValue] = [
            .init(), .init(), .init()
        ]
        
        var recorrenceValues: [RecorrenceValue] = [
            .init(), .init(), .init()
        ]
        
        var inputNewVale = false
        
        var fixedCard: CardBalance.State {
            get { .init(values: fixedValues.map { .init(value: $0.value)}) }
            set { /* fixedValues = newValue.values */ }
        }
        
        var fixedInput: FixedInput.State {
            get { .init(modelList: fixedValues) }
            set { fixedValues = newValue.modelList }
        }
        
        var recorrenceInput: RecorrenceInput.State {
            get { .init(modelList: recorrenceValues) }
            set { recorrenceValues = newValue.modelList }
        }
    }
    
    enum Action: Equatable {
        case addValue
        case showInputValue
        case hiddenInputValue
        case fixedValue(CardBalance.Action)
        case fixedInput(FixedInput.Action)
        case recorrenceInput(RecorrenceInput.Action)
    }
    
    struct Environment: Equatable, Hashable {}
    
    static let reducer: Reducer = .combine(
        CardBalance.reducer.pullback(
            state: \.fixedCard,
            action: /BalanceList.Action.fixedValue,
            environment: { _ in .init() }
        ),
        
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
            case .addValue:
                return .none
                
            case .fixedInput(.addValue):
                state.inputNewVale = false
                return .none
                
            case .fixedInput:
                return .none
                
            case .fixedValue(.addValue):
                state.inputNewVale = true
                return .none
                
            case .showInputValue:
                return .none
                
            case .hiddenInputValue:
                state.inputNewVale = false
                return .none
              
            case .recorrenceInput(.addValue):
                state.inputNewVale = false
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
                            get: \.inputNewVale,
                            send: { $0 ? .showInputValue : .hiddenInputValue }
                        ),
                        label: { EmptyView() })
                    
                    
                    ScrollView {
                        LazyVStack.init(alignment: .center, spacing: .spacing_10) {
                            CardBalance.View(store: store.scope(
                                state: \.fixedCard,
                                action: BalanceList.Action.fixedValue
                            ))
                            
                            CardBalance.View(store: store.scope(
                                state: \.fixedCard,
                                action: BalanceList.Action.fixedValue
                            ))
                        }
                    }
                }
            }
        }
        
        let store: Store
    }
    
}
