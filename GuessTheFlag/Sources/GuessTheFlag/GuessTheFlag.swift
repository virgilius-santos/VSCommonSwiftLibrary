
import SwiftUI

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct ContentView: View {
    
    var body: some View {
        
        ZStack {
            
//            LinearGradient(
//                gradient: Gradient(colors: [.white, .black]),
//                startPoint: .top,
//                endPoint: .bottom
//            )
//            .ignoresSafeArea(.all)
            
//            RadialGradient(
//                gradient: Gradient(colors: [.blue, .black]),
//                center: .center,
//                startRadius: 20,
//                endRadius: 200
//            )
            
//            AngularGradient(
//                gradient: Gradient(colors: [.red, .yellow, .green, .blue, .purple, .red]),
//                center: .center
//            )
            
            VStack(alignment: .trailing, spacing: 20) {
                
                HStack(spacing: 20) {
                    Text("teste")
                    Text("teste").background(
                        AngularGradient(
                            gradient: Gradient(colors: [.red, .yellow, .green, .blue, .purple, .red]),
                            center: .center
                        )
                    )
                }
                
                HStack(spacing: 20) {
                    Text("teste")
                    Text("teste")
                }
            }
        }
        
    }
}
