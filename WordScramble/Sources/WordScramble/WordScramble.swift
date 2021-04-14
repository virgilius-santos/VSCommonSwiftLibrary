

import SwiftUI
import FoundationExtensions
import Styles

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        WordScrambleView()
    }
}

struct WordScrambleView: View {
    @State var model = WordScrambleModel()
    
    var body: some View {
        NavigationView {
                VStack {
                    TextField("Enter your word", text: $model.newWord, onCommit: addNewWord)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .autocapitalization(.none)
                        .padding()
                    
                    List(model.usedWords, id: \.self) {
                        Image(systemName: "\($0.count).circle")
                        Text($0)
                    }
                }
                .navigationBarTitle(model.rootWord)
                .onAppear(perform: {
                    model.startGame()
                })
                .alert(isPresented: $model.alert.showing, message: model.alert)
            }
    }
    
    func addNewWord() {
        model.addNewWord()
    }
}

struct WordScrambleModel {
    var startWords = readFileContent()
   
    var usedWords = [String]()
    var rootWord = ""
    var newWord = ""
    
    var alert = AlertMessage()
    
    var allWords: [String] { startWords.components(separatedBy: "\n") }
    
    mutating func addNewWord() {
        // lowercase and trim the word, to make sure we don't add duplicate words with case differences
        let answer = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)

        // exit if the remaining string is empty
        guard answer.count > 0 else { return }

        guard isOriginal(word: answer) else {
            alert = .init(
                title: "Word used already",
                message: "Be more original",
                showing: true
            )
            return
        }

        guard isPossible(word: answer) else {
            alert = .init(
                title: "Word not recognized",
                message: "You can't just make them up, you know!",
                showing: true
            )
            return
        }

        guard textChecker(answer) else {
            alert = .init(
                title: "Word not possible",
                message: "That isn't a real word.",
                showing: true
            )
            return
        }

        usedWords.insert(answer, at: 0)
        newWord = ""
    }
    
    mutating func startGame() {
        rootWord = randomString(allWords) ?? "silkworm"
    }
    
    func isOriginal(word: String) -> Bool {
        !usedWords.contains(word)
    }
    
    func isPossible(word: String) -> Bool {
        var tempWord = rootWord

        for letter in word {
            if let pos = tempWord.firstIndex(of: letter) {
                tempWord.remove(at: pos)
            } else {
                return false
            }
        }

        return true
    }
}

var textChecker: (_ word: String) -> Bool = { word in
    let checker = UITextChecker()
    let range = NSRange(location: 0, length: word.utf16.count)
    let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
    let allGood = misspelledRange.location == NSNotFound
    return allGood
}

var readFileContent: () -> String = {
    guard let fileString = file(from: "start", in: .module) else {
        fatalError("file not found")
    }
    return fileString
}

var randomString: ([String]) -> String? = {
    $0.randomElement()
}
