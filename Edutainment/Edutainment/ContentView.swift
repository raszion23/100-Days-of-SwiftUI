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
                }

                // Check answer
                Button(action: {
                    // Check answer
                    calculate()
                    // New question
                    createQuestion()

                }, label: {
                    Text("Submit")
                })
            }
            .navigationTitle("iMultiply")
        }
        .onAppear {
            createQuestion()
        }
        // Show alert
        .alert(alertTitle, isPresented: $showingAlert) {
            Button("OK") {
                count = 1
            }
        } message: {
            Text(alertMessage)
        }
    }

    // Create questions
    func createQuestion() {
        let ranInt = Int.random(in: 0 ... 12)
        question = "\(multiplicationTable) x \(ranInt)"
    }

    // Check user's answer
    func calculate() {
        counter()
    }

    // Count how many questions passed
    func counter() {
        if count < numberOfQuestions {
            count += 1
        } else {
            // Set alert title and messages
            alertTitle = "Finished!"
            alertMessage = "You have answered \(count) questions!"
            showingAlert = true
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
