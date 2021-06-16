
import SwiftUI
import Combine
import ComposableArchitecture
import Styles

struct CardBalance_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            
            ZStack {
                Color.offWhite.edgesIgnoringSafeArea(.all)
                
                ScrollView {
                    LazyVStack.init(alignment: .center, spacing: .spacing_10) {
                        ForEach(1...1, id: \.self) { count in
                            CardBalance.View(store: .init(
                                initialState: .init(),
                                reducer: CardBalance.reducer,
                                environment: .init()
                            ))
                        }
                    }
                }
            }
        }
    }
}

public enum CardBalance {}

public extension CardBalance {
    typealias Store = ComposableArchitecture.Store<State, Action>
    typealias Reducer = ComposableArchitecture.Reducer<State, Action, Environment>
    
    struct State: Equatable, Hashable {
        var title: String = "Gastos Fixos"
        
        var valueTitle: String = "Total: "
        var value: String = "R$ 2000.00"
    }

    enum Action: Equatable, Hashable {
        case addValue
    }

    struct Environment: Equatable, Hashable {}
    
    static let reducer: Reducer = .empty
    
    struct View: SwiftUI.View {
        
        public var body: some SwiftUI.View {
            WithViewStore(store) { viewStore in
                HStack(alignment: .top) {
                    VStack(alignment: .leading) {
                        Text(viewStore.title)
                            .font(.headline)
                            .foregroundColor(.secondary)
                        
                        Spacer.init(minLength: .spacing_10)
                        
                        Group {
                            Text(viewStore.valueTitle)
                                .font(.caption2)
                                .fontWeight(.black)
                                .foregroundColor(.primary)
                                .lineLimit(3)
                            Text(viewStore.value)
                                .font(.callout)
                                .foregroundColor(.secondary)
                        }
                        
                    }
                    Spacer()
                    VStack(alignment: .trailing, spacing: .spacing_10) {
                        Spacer()
                        FloatingButton(iconName: "plus.circle.fill", action: { viewStore.send(.addValue) } )
                    }
                    
                }
                .modifier(CardStyle())
            }
        }
        
        let store: Store
    }
}

struct FloatingButtonGroup<T: View>: View {
    
    let content: () -> T
    
    init(@ViewBuilder content: @escaping () -> T) {
        self.content = content
    }
    
    var body: some View {
        VStack.init(alignment: .trailing, spacing: .spacing_10) {
            Spacer()
            HStack.init(alignment: .bottom, spacing: .spacing_10, content: {
                Spacer()
                content()
            })
        }
    }
}

struct FloatingButton: View {
    
    let iconName: String
    let action: () -> Void
    
    var body: some View {
        Button(action: action, label: {
            Image(systemName: iconName)
                .foregroundColor(.darkStart)
        })
        .buttonStyle(SimpleButtonStyle())
        .frame(minWidth: .minClickableWidth, minHeight: .minClickableHeight)
    }
}


struct CardStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding()
            .background(Color.white)
            .cornerRadius(.radius_10)
            .overlay(
                RoundedRectangle(cornerRadius: .radius_10)
                    .stroke(Color.white, lineWidth: .lineWidth_1)
            )
            .shadow(style: .blackLight)
            .shadow(style: .whiteDark)
            .padding([.top, .horizontal])
    }
}
