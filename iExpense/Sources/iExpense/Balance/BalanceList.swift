import SwiftUI
import ComposableArchitecture

struct BalanceList_Previews: PreviewProvider {
  static var previews: some View {
    NavigationView {
      BalanceList.View(store: {
        let store = BalanceList.Store.init(
          initialState: .init(),
          reducer: BalanceList.reducer,
          environment: .init()
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
    
    var fixedInput: Card<FixedInput.State, FixedValue, BalanceCard.State>
    var recurrenceInput: Card<RecurrenceInput.State, RecurrenceValue, BalanceCard.State>
    
    init(
      fixedValues: [FixedValue] = [.init(id: .init()), .init(id: .init())],
      recurrenceValues: [RecurrenceValue] = [.init(id: .init()), .init(id: .init())]
    ) {
      
      self.fixedInput = .init(
        values: fixedValues,
        makeCard: {
          .init(title: "Gastos Fixos", values: $0.map(\.value))
        }
      )
      
      self.recurrenceInput = .init(
        values: recurrenceValues,
        makeCard: {
          .init(title: "Gastos Recorrentes", values: $0.map(\.pawn))
        }
      )
    }
  }
  
  enum Action: Equatable {
    case appear
    case showFixedView
    case showRecurrenceView
  }
  
  struct Environment {
  }
  
  static let reducer: Reducer = .init { state, action, _ in
    switch action {
    case .appear:
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
