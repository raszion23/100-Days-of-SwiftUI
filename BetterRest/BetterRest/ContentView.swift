//
//  ContentView.swift
//  BetterRest
//
//  Created by Raszion23 on 1/6/22.
//

import CoreML
import SwiftUI

struct ContentView: View {
    @State private var wakeUp = defaultWakeTime
    @State private var sleepAmount = 8.0
    @State private var coffeeAmount = 1
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var showingAlert = false

    static var defaultWakeTime: Date {
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        return Calendar.current.date(from: components) ?? Date.now
    }

    var recommendedBedtime: String {
        let bedTime = calculateBedtime()
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mm a"
        return formatter.string(from: bedTime)
    }

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("When do you want to wake up?")
                    .font(.headline),
                    content: {
                        DatePicker("Please enter a time", selection: $wakeUp, displayedComponents: .hourAndMinute)
                            .labelsHidden()
                    })

                Section(header: Text("Desired amount of sleep")
                    .font(.headline),
                    content: {
                        Stepper("\(sleepAmount.formatted()) hours", value: $sleepAmount, in: 4 ... 12, step: 0.25)
                    })

                Section(header: Text("Daily coffee intake")
                    .font(.headline),
                    content: {
                        Picker("Cups of coffee", selection: $coffeeAmount) {
                            ForEach(1 ... 20, id: \.self) { cups in
                                Text(cups == 1 ? "1 cup" : "\(cups) cups")
                            }
                        }

                    })

                Section(content: { Text(recommendedBedtime) },
                        header: { Text("Recommended bedtime")

                        })
            }
            .navigationTitle("BetterRest")
            .alert(alertTitle, isPresented: $showingAlert) {
                Button("OK") {}
            } message: {
                Text(alertMessage)
            }
        }
    }

    func calculateBedtime() -> Date {
        var sleepTime = Date()

        do {
            let config = MLModelConfiguration()
            let model = try SleepCalculator(configuration: config)
            let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
            let hour = (components.hour ?? 0) * 60 * 60
            let minute = (components.minute ?? 0) * 60
            let prediction = try model.prediction(wake: Double(hour + minute), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount))
            sleepTime = wakeUp - prediction.actualSleep

        } catch {
            alertTitle = "Error"
            alertMessage = "Sorry, there was a problem calculating your bedtime."
            showingAlert = true
        }

        return sleepTime
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
