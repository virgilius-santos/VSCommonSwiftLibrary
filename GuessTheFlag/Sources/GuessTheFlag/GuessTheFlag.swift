
import SwiftUI
import Styles
import Functions

public extension GuessTheFlagView {
    static let mock = GuessTheFlagView()
}

public struct GuessTheFlagView: View {
    
    @State private var viewModel: GuessTheFlagViewModel = .init()
    
    public init() {}
    
    public var body: some View {
        
        ZStack {
            
            LinearGradient(Color.blue, .black, startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 20) {
                VStack {

                    Text("Tap the flag of")
                        |> textStyle(size: 24)

                    Text(viewModel.correctCountry)
                        |> textStyle(size: 36, weight: .bold)

                }

                ForEach(0 ..< 3) { number in
                    Button(action: {
                        viewModel.flagTapped(number)
                    }) {
                        viewModel.countries[number]
                            |> image(from:)
                            |> { view in
                                view.clipShape(Capsule())
                                    .overlay(Capsule().stroke(Color.black, lineWidth: 1))
                                    .shadow(color: .black, radius: 2)
                            }
                    }
                }
                
                VStack {

                    Text("Your Score is: \(viewModel.score)")
                        |> textStyle(size: 24)
                }
                
                Spacer()
            }
            
        }
        .alert(isPresented: $viewModel.showingScore) {
            Alert(
                title: Text(viewModel.scoreTitle),
                message: Text("Your score is \(viewModel.score)"),
                dismissButton: .default(
                    Text("Continue"),
                    action: { viewModel.askQuestion() }
                )
            )
        }
    }
}

struct GuessTheFlagViewModel {
    var countries = [
        "Estonia",
        "France",
        "Germany",
        "Ireland",
        "Italy",
        "Nigeria",
        "Poland",
        "Russia",
        "Spain",
        "UK",
        "US"
    ].shuffled()
    
    var correctAnswer = Int.random(in: 0...2)
    
    var correctCountry: String { countries[correctAnswer] }
    
    var showingScore = false
    
    var scoreTitle = ""
    
    var score = 0
    
    mutating func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct"
            score += 1
        } else {
            scoreTitle = "Wrong! That’s the flag of \(countries[number]),"
            score -= 1
        }

        showingScore = true
    }
    
    mutating func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
}


public func image(from name: String) -> Image {
    Image(uiImage: UIImage(named: name, in: .module, compatibleWith: nil)!)
        .renderingMode(.original)
}
