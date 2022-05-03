//
//  ContentView.swift
//  WordScramble
//
//  Created by Raszion23 on 5/3/22.
//

import SwiftUI

struct ContentView: View {
    // Array of words already used
    @State private var usedWords = [String]()
    // Root word to spell other words from
    @State private var rootWord = ""
    // String that can be binded to a textfield
    @State private var newWord = ""

    var body: some View {
        NavigationView {
            List {
                Section {
                    // User input word to guess
                    TextField("Enter your word", text: $newWord)
                        .autocapitalization(.none)
                }

                Section {
                    // Add guessed words to a list
                    ForEach(usedWords, id: \.self) { word in
                        HStack {
                            // Show length of word using SF Symbols
                            Image(systemName: "\(word.count).circle")
                            Text(word)
                        }
                    }
                }
            }
            // Rootword is the title
            .navigationTitle(rootWord)

            // Calls addNewWord() when user presses return on keyboard
            .onSubmit {
                addNewWord()
            }

            // Calls startGame() when view is shown
            .onAppear {
                startGame()
            }
        }
    }

    // Add user entry to usedWords array
    func addNewWord() {
        // Lowercase and trim the word, to make sure duplicate words with different cases are add
        let answer = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)

        // Exit if the remaining string is empty
        guard answer.count > 0 else {
            return
        }

        // Extra validation to come

        // Insert the word at position 0 in usedWords array
        withAnimation {
            usedWords.insert(answer, at: 0)
        }

        // Set newWord to an empty string
        newWord = ""
    }

    // Start game when view is shown
    func startGame() {
        // Find the URL for start.txt in app bundle
        if let startWordURL = Bundle.main.url(forResource: "start", withExtension: "txt") {
            // Load start.txt into a string
            if let startWords = try? String(contentsOf: startWordURL) {
                // Split the string up into an array od strings, splitting on line breaks
                let allWords = startWords.components(separatedBy: "\n")

                // Pick one random word, or use "silkword" as default
                rootWord = allWords.randomElement() ?? "silkworm"

                // If everything works, then exit
                return
            }
        }

        // If there is a problem, then trigger a crash and report error
        fatalError("Could not load start.txt from bundle.")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
