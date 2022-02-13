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
      get {
        .init(
          fixedValues: fixedValues,
          recurrenceValues: recurrenceValues
        )
      }
      set {
        fixedValues = newValue.fixedInput.values
        recurrenceValues = newValue.recurrenceInput.values
      }
    }
    
    var navigationState: NavState = .none
  }
  
  enum Action: Equatable {
    case didAppear
    case listAction(BalanceList.Action)
    case navigation(BalanceRouter.NavAction)
  }
  
  struct Environment {
    var uuid: () -> UUID = UUID.init
  }
  
  static let reducer: Reducer = BalanceRouter.navReducer
    .pullback(
      state: \.navigationState,
      action: /BalanceRouter.Action.navigation,
      environment: { _ in .init() }
    )
    .combined(with: BalanceList.reducer.pullback(
      state: \.balanceList,
      action: /BalanceRouter.Action.listAction,
      environment: { _ in .init() }
    ))
    .combined(with: .init { state, action, env in
      switch action {
      case .listAction(.showFixedView):
        state.navigationState = .fixed(.init(
          value: .init(id: env.uuid()),
          values: state.fixedValues
        ))
        return .none
        
      case .navigation(.fixed(.addValue)):
        if case let .fixed(fixedState) = state.navigationState {
          state.fixedValues = fixedState.values
        }
        state.navigationState = .none
        return .none
        
      case .listAction(.showRecurrenceView):
        state.navigationState = .recurrence(.init(
          value: .init(id: env.uuid()),
          values: state.recurrenceValues
        ))
        return .none
        
      case .navigation(.recurrence(.addValue)):
        if case let .recurrence(recurrenceState) = state.navigationState {
          state.recurrenceValues = recurrenceState.values
        }
        state.navigationState = .none
        return .none
        
      case .navigation(.navigationStatus(false)):
        state.navigationState = .none
        return .none
        
      default:
        return .none
      }
    })
  
  struct View: SwiftUI.View {
    
    public var body: some SwiftUI.View {
      ZStack {
        
        WithViewStore(store) { viewStore in
          NavView.init(
            store: store.scope(
              state: \.navigationState,
              action: BalanceRouter.Action.navigation
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

public extension BalanceRouter {
  typealias NavReducer = ComposableArchitecture.Reducer<NavState, NavAction, NavEnvironment>
  typealias NavStore = ComposableArchitecture.Store<NavState, NavAction>
  
  enum NavState: Equatable {
    case fixed(FixedInput.State)
    case recurrence(RecurrenceInput.State)
    case none
    
    var navigate: Bool { self != .none }
  }
  
  enum NavAction: Equatable {
    case fixed(FixedInput.Action)
    case recurrence(RecurrenceInput.Action)
    
    case navigationStatus(Bool)
  }
  
  struct NavEnvironment {}
  
  static let navReducer: NavReducer = .combine(
    FixedInput.reducer
      .pullback(
        state: /BalanceRouter.NavState.fixed,
        action: /BalanceRouter.NavAction.fixed,
        environment: { _ in .init() }
      ),
    
    RecurrenceInput.reducer
      .pullback(
        state: /BalanceRouter.NavState.recurrence,
        action: /BalanceRouter.NavAction.recurrence,
        environment: { _ in .init() }
      )
  )
  
  struct NavView: SwiftUI.View {
    
    let store: NavStore
    
    public var body: some SwiftUI.View {
      WithViewStore.init(store, content: { viewStore in
        NavigationLink.lazy(
          isActive: viewStore.binding(
            get: \.navigate,
            send: BalanceRouter.NavAction.navigationStatus
          ),
          destination: {
            switch viewStore.state {
            case .fixed(let state):
              FixedInput.View.init(store: store.scope(
                state: { _ in state },
                action: BalanceRouter.NavAction.fixed
              ))
            case .recurrence(let state):
              RecurrenceInput.View.init(store: store.scope(
                state: { _ in state },
                action: BalanceRouter.NavAction.recurrence
              ))
            case .none:
              EmptyView()
            }
          }
        )
      })
    }
  }
}
