
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
                            CardBalance.View(state: .init()) {}
                        }
                    }
                }
            }
        }
    }
}

public enum CardBalance {}

public extension CardBalance {
    struct State: Equatable {
        var title: String = "Gastos Fixos"
        var valueTitle: String = "Total: "
        var values: [Double]
        
        var value: NSNumber {
            NSNumber(value: values.reduce(0, +))
        }
        
        init(
            title: String = "Gastos Fixos",
            valueTitle: String = "Total: ",
            values: [Double] = [.init(1000), .init(500)]
        ) {
            self.title = title
            self.valueTitle = valueTitle
            self.values = values
        }
    }
    
    struct View: SwiftUI.View {
        
        public var body: some SwiftUI.View {
            HStack(alignment: .top) {
                VStack(alignment: .leading) {
                    Text(state.title)
                        .font(.headline)
                        .foregroundColor(.secondary)
                    
                    Spacer.init(minLength: .spacing_10)
                    
                    Group {
                        Text(state.valueTitle)
                            .font(.caption2)
                            .fontWeight(.black)
                            .foregroundColor(.primary)
                            .lineLimit(3)
                        
                        Text(state.value, formatter: currencyFormatter)
                            .font(.callout)
                            .foregroundColor(.secondary)
                    }
                    
                }
                Spacer()
                VStack(alignment: .trailing, spacing: .spacing_10) {
                    Spacer()
                    FloatingButton(
                        iconName: "plus.circle.fill",
                        action: { action() }
                    )
                }
                
            }
            .modifier(CardStyle())
        }
        
        let state: State
        let action: () -> Void
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
