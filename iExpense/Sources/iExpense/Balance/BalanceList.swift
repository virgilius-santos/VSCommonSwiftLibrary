
import SwiftUI
import ComposableArchitecture

struct BalanceList_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            BalanceList.View(store: {
                let storage = BalanceLocalStorage()
                let store = BalanceList.Store.init(
                    initialState: .init(),
                    reducer: BalanceList.reducer,
                    environment: .init(
                        fixedValues: storage.getFixedValues,
                        recurrenceValues: storage.getRecurrentValues
                    )
                )
                return store
            }())
        }
    }
}

public enum BalanceList {}

public extension BalanceList {
    typealias Store = ComposableArchitecture.Store<State, Action>
    typealias Reducer = ComposableArchitecture.Reducer<State, Action, Environment>
    
    struct Card<StateValue: Equatable, Value: Equatable, State: Equatable>: Equatable {
        var values: [Value] = []
        var makeCard: ([Value]) -> State
        var card: State { makeCard(values) }
        
        public static func == (lhs: Self, rhs: Self) -> Bool {
                lhs.values == rhs.values
                && lhs.card == rhs.card
        }
    }
    
    struct State: Equatable {

        var fixedInput: Card<FixedInput.State, FixedValue, BalanceCard.State> = .init(
            values: [.init(id: .init()), .init(id: .init())],
            makeCard: {
                .init(title: "Gastos Fixos", values: $0.map(\.value))
            }
        )
        
        var recurrenceInput: Card<RecurrenceInput.State, RecurrenceValue, BalanceCard.State> = .init(
            values: [.init(id: .init()), .init(id: .init())],
            makeCard: {
                .init(title: "Gastos Recorrentes", values: $0.map(\.pawn))
            }
        )
    }
    
    enum Action: Equatable {
        case appear
        case showFixedView
        case showRecurrenceView
    }
    
    struct Environment {
        var fixedValues: () -> [FixedValue]
        var recurrenceValues: () -> [RecurrenceValue]
        
        public init(
            fixedValues: @escaping () -> [FixedValue],
            recurrenceValues: @escaping () -> [RecurrenceValue]
        ) {
            self.fixedValues = fixedValues
            self.recurrenceValues = recurrenceValues
        }
    }
    
    static let reducer: Reducer = .init { state, action, environment in
        switch action {
        case .appear:
            state.fixedInput.values = environment.fixedValues()
            state.recurrenceInput.values = environment.recurrenceValues()
            return .none
            
        case .showFixedView:
            return .none
            
        case .showRecurrenceView:
            return .none
        }
    }
    
    struct View: SwiftUI.View {
        public var body: some SwiftUI.View {
            WithViewStore(store) { viewStore in
                ZStack {
                    Color.offWhite.edgesIgnoringSafeArea(.all)
                    
                    ScrollView {
                        LazyVStack.init(alignment: .center, spacing: .spacing_10) {
                            BalanceCard.View(
                                state: viewStore.fixedInput.card,
                                action: { viewStore.send(.showFixedView) }
                            )
                            
                            BalanceCard.View(
                                state: viewStore.recurrenceInput.card,
                                action: { viewStore.send(.showRecurrenceView) }
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
