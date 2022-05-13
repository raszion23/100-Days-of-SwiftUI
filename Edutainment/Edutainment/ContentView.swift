//
//  ContentView.swift
//  Edutainment
//
//  Created by Raszion23 on 5/12/22.
//

import SwiftUI

struct ContentView: View {
    // Multiplication tables to practice
    @State private var multiplicationTable = 2
    // Number of questions to ask
    @State private var numberOfQuestions = 5
    // Display question
    @State private var question = "2 x 5"
    // Hold user's answer
    @State private var answer = ""
    // Count number of questions answered
    @State private var count = 1
    // Alert title
    @State private var alertTitle = ""
    // Alert message
    @State private var alertMessage = ""
    // Show alert
    @State private var showingAlert = false
    // Alert 2 title
    @State private var alertTitle2 = ""
    // Alert 2 message
    @State private var alertMessage2 = ""
    // Show alert 2
    @State private var showingAlert2 = false
    // Hold random number from 1 - 12
    @State private var ranInt = 0

    var body: some View {
        NavigationView {
            Form {
                // User's settings
                Section {
                    VStack {
                        // Stepper for multiplicatio table
                        Stepper("Multiplication Table of:  \(multiplicationTable)", onIncrement: {
                            if multiplicationTable < 12 {
                                multiplicationTable += 1
                            }
                        }, onDecrement: {
                            if multiplicationTable > 2 {
                                multiplicationTable -= 1
                            }
                        })
                        // Stepper for number of questions
                        Stepper("Number of Questions:  \(numberOfQuestions)", value: $numberOfQuestions, in: 5 ... 20)
                    }
                }

                // Display question and accept user's answer
                Section {
                    Text(question)
                    TextField("Enter Answer", text: $answer)
                        .keyboardType(.numberPad)
                }

                // Check answer
                Button(action: {
                    // Check answer
                    calculate(input: Int(answer) ?? 0)
                }, label: {
                    Text("Submit")
                })
            }
            // Navigation bar title
            .navigationTitle("iMultiply")
        }
        // When app loads, a question is created
        .onAppear {
            createQuestion()
        }
        // Show alert
        .alert(alertTitle, isPresented: $showingAlert) {
            Button("OK") {}
        } message: {
            Text(alertMessage)
        }
        // Show alert2
        .alert(alertTitle2, isPresented: $showingAlert2) {
            Button("OK") {}
        } message: {
            Text(alertMessage2)
        }
    }

    // Create questions
    func createQuestion() {
        ranInt = Int.random(in: 0 ... 12)
        question = "\(multiplicationTable) x \(ranInt)"
    }

    // Check user's answer
    func calculate(input: Int) {
        // Answer from question
        let result = multiplicationTable * ranInt

        // Determine if answer is correct
        if input == result {
            // Set alert title and message
            alertTitle = "Correct!"
            alertMessage = "Good Job!"
            showingAlert = true

        } else {
            // Set alert title and message
            alertTitle = "Wrong!"
            alertMessage = "The correct answer is: \(result)!"
            showingAlert = true
        }

        // Clear answer Textfield
        answer = ""
        // Call new question
        createQuestion()
        // Increase count
        counter()
    }

    // Count how many questions passed
    func counter() {
        if count < numberOfQuestions {
            count += 1
        } else {
            // Set alert title and messages
            alertTitle2 = "Finished!"
            alertMessage2 = "You have answered \(count) questions!"
            showingAlert2 = true
            count = 1
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
