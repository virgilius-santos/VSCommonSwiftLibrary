

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
