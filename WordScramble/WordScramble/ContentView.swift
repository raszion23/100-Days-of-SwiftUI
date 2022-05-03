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
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
