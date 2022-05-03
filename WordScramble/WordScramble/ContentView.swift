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

    // Alert properties
    @State private var errorTittle = ""
    @State private var errorMessage = ""
    @State private var showingError = false

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

            // Call alert
            .alert(errorTittle, isPresented: $showingError) {
                Button("OK", role: .cancel) {}
            } message: {
                Text(errorMessage)
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

        // newWord validations
        guard isOriginal(word: answer) else {
            wordError(title: "Word used already", message: "Try again")
            return
        }

        guard isPossible(word: answer) else {
            wordError(title: "Word not possible", message: "Try again")
            return
        }

        guard isReal(word: answer) else {
            wordError(title: "Word not recognized", message: "Try again")
            return
        }

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

    // Verify if word hasn't been used already
    func isOriginal(word: String) -> Bool {
        !usedWords.contains(word)
    }

    // Check whether a random word can be made out of the letters from rootWord
    func isPossible(word: String) -> Bool {
        // Create variable copy of rootWord
        var tempWord = rootWord

        // Loop over each letter of user's input word
        for letter in word {
            // See if letter exist in tempWord
            if let pos = tempWord.firstIndex(of: letter) {
                // Remove letter from tempWord
                tempWord.remove(at: pos)
            } else {
                return false
            }
        }

        return true
    }

    // Verify if the word is real
    func isReal(word: String) -> Bool {
        // Create instance of UITextChecker
        let checker = UITextChecker()
        // Create instance of NSRange to scan entire length of string
        let range = NSRange(location: 0, length: word.utf16.count)
        // Call rangeOfMisspelledWord() on UITextChecker to look for wrong words
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")

        // If word is correct
        return misspelledRange.location == NSNotFound
    }

    // Alert
    func wordError(title: String, message: String) {
        errorTittle = title
        errorMessage = message
        showingError = true
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
