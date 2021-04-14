

import SwiftUI
import FoundationExtensions
import Styles

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        WordScrambleView()
    }
}

public struct WordScrambleView: View {
    @State var model = WordScrambleModel()
    
    public init() {}
    
    public var body: some View {
        NavigationView {
                Form {
                    Section(header: Text("Input your word:")) {
                        TextField("Enter your word", text: $model.newWord, onCommit: addNewWord)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .autocapitalization(.none)
                            .padding()
                    }
                    
                    Section(header: Text("Words list:")) {
                        List(model.usedWords, id: \.self) {
                            Image(systemName: "\($0.count).circle")
                            Text($0)
                        }
                    }
                    
                    Section(header: Text("Score:")) {
                        Text("\(model.points) points").font(.title2)
                    }
                }
                .navigationBarTitle(model.rootWord)
                .onAppear(perform: {
                    model.startGame()
                })
                .alert(isPresented: $model.alert.showing, message: model.alert)
                .navigationBarItems(leading: Button("Restart", action: { model.startGame() }))
            }
    }
    
    func addNewWord() {
        model.addNewWord()
    }
}

enum Validation {
    case success
    case error(message: AlertMessage)
}

typealias ValidationFunction = (_ word: String, _ usedWords: [String], _ rootWord: String) -> Validation

extension Array where Element == ValidationFunction {
    func validate(_ word: String, _ usedWords: [String], _ rootWord: String) -> Validation {
        for rule in self {
            let result = rule(word, usedWords, rootWord)
            switch result {
            case .success:
                continue
            case .error:
                return result
            }
        }
        return .success
    }
}

struct WordScrambleModel {
    var allWords = readFileContent()
   
    var usedWords = [String]()
    var rootWord = ""
    var newWord = ""
    
    var points: Int {
        usedWords.reduce(0, { $0 + $1.count * 5 })
    }
    
    var alert = AlertMessage()
    
    var rules: [ValidationFunction] = [
        isDifferent,
        isLong,
        isOriginal,
        isPossible,
        isSpelledWord
    ]
    
    mutating func addNewWord() {
        // lowercase and trim the word, to make sure we don't add duplicate words with case differences
        let answer = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)

        // exit if the remaining string is empty
        switch rules.validate(answer, usedWords, rootWord) {
        case .success:
            usedWords.insert(answer, at: 0)
            newWord = ""
        case let .error(message):
            alert = message
        }
    }
    
    mutating func startGame() {
        rootWord = randomString(allWords) ?? "silkworm"
        usedWords = []
    }
}

var isDifferent: ValidationFunction = { (word, _, rootWord) -> Validation in
    guard !word.elementsEqual(rootWord) else {
        return .error(message: .init(
            title: "Word used is the original",
            message: "Be more original",
            showing: true
        ))
    }
    return .success
}

var isLong: ValidationFunction = { (word, _, _) -> Validation in
    guard word.count > 2 else {
        return .error(message: .init(
            title: "Word used is too short",
            message: "Be more original",
            showing: true
        ))
    }
    return .success
}

var isOriginal: ValidationFunction = { (word, usedWords, rootWord) -> Validation in
    guard word.count > 0 else {
        return .error(message: .init(
            title: "Word used already",
            message: "Be more original",
            showing: true
        ))
    }
    return .success
}

var isPossible: ValidationFunction = { (word, usedWords, _) -> Validation in
    guard !usedWords.contains(word) else {
        return .error(message: .init(
            title: "Word not recognized",
            message: "You can't just make them up, you know!",
            showing: true
        ))
    }
    return .success
}

var isSpelledWord: ValidationFunction = { (word, _, _) -> Validation in
    guard textChecker(word) else {
        return .error(message: .init(
            title: "Word not possible",
            message: "That isn't a real word.",
            showing: true
        ))
    }
    return .success
}

var textChecker: (_ word: String) -> Bool = { word in
    let checker = UITextChecker()
    let range = NSRange(location: 0, length: word.utf16.count)
    let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
    let allGood = misspelledRange.location == NSNotFound
    return allGood
}

var readFileContent: () -> [String] = {
    guard let fileString = file(from: "start", in: .module) else {
        fatalError("file not found")
    }
    return fileString.lowercased().components(separatedBy: "\n")
}

var randomString: ([String]) -> String? = {
    $0.randomElement()
}
