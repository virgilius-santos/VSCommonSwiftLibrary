
import SwiftUI
import Combine
import ComposableArchitecture
import Styles

enum CardBalance {
    struct State: Equatable, Hashable {
        
    }

    enum Action: Equatable, Hashable {
        
    }

    struct Environment: Equatable, Hashable {
        
    }
    
    static let balanceReduce: Reducer<State, Action, Environment> = .combine(
    
    
    )
}

public struct CardBalanceView: View {
    public var body: some View {
        ZStack {
            VStack(alignment: .leading) {
                Text("SwiftUI")
                    .font(.headline)
                    .foregroundColor(.secondary)
                Text("Drawing a Border with Rounded Corners")
                    .font(.title)
                    .fontWeight(.black)
                    .foregroundColor(.primary)
                    .lineLimit(3)
                Text("Written by Simon Ng".uppercased())
                    .font(.caption)
                    .foregroundColor(.secondary)
                
                
            }
            
            FloatingButtonGroup {
                FloatingButton(iconName: "list.bullet", action: {})
                
                FloatingButton(iconName: "plus.circle.fill", action: {})
            }
            
        }
        .modifier(CardStyle())
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

struct CardBalance_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            
            ZStack {
                Color.offWhite.edgesIgnoringSafeArea(.all)
                
                ScrollView {
                    LazyVStack.init(alignment: .center, spacing: .spacing_10) {
                        ForEach(1...10, id: \.self) { count in
                            CardBalanceView()
                        }
                    }
                }
            }
        }
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
