
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
                        .baseStyle(size: 24)

                    Text(viewModel.correctCountry)
                        .baseStyle(size: 36, weight: .bold)

                }

                ForEach(0 ..< 3) { number in
                    Button(action: {
                        viewModel.flagTapped(number)
                    }) {
                        image(from: viewModel.countries[number], in: .module)
                            .capsuleStyle()
                    }
                }
                
                VStack {

                    Text("Your Score is: \(viewModel.score)")
                        .baseStyle(size: 24)
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
