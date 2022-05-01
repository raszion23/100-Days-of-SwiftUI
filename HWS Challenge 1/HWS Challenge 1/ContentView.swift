//
//  ContentView.swift
//  HWS Challenge 1
//
//  Created by Raszion23 on 12/29/21.
//

import SwiftUI

struct ContentView: View {
    @State private var inputUnit = 0
    @State private var outputUnit = 0
    @State private var userValue = 0.0

    let units = ["Celsius", "Fahrenheit", "Kelvin"]
    

    var conversion: Double {
        var results = 0.0

        // Celsius to Fahrenheit
        if inputUnit == 0 && outputUnit == 1 {
            results = (userValue * 9 / 5) + 32
        }
        // Fahrenheit to Celsius
        else if inputUnit == 1 && outputUnit == 0 {
            results = (userValue - 32) * 5 / 9
        }

        // Celsius to Kelvin
        if inputUnit == 0 && outputUnit == 2 {
            results = userValue + 273.15
        }
        // Kelvin to Celsius
        else if inputUnit == 2 && outputUnit == 0 {
            results = userValue - 273.15
        }

        // Fahrenheit to Kelvin
        if inputUnit == 1 && outputUnit == 2 {
            results = (userValue - 32) * 5 / 9 + 273.15
        }
        // Kelvin to Fahrenheit
        else if inputUnit == 2 && outputUnit == 1 {
            results = (userValue - 273.15) * 9 / 5 + 32
        }
        
        if inputUnit == outputUnit {
            results = userValue
        }

        return results
    }

    var body: some View {
        NavigationView {
            Form {
                Section {
                    Picker("Convert from:", selection: $inputUnit) {
                        ForEach(0 ..< units.count) {
                            Text(units[$0])
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                } header: {
                    Text("Convert from:")
                }

                Section {
                    TextField("Temperature", value: $userValue, format: .number)
                        .keyboardType(.decimalPad)
                } header: {
                    Text("Input Temperature:")
                }

                Section {
                    Picker("Convert from:", selection: $outputUnit) {
                        ForEach(0 ..< units.count) {
                            Text(units[$0])
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                } header: {
                    Text("Convert to:")
                }

                Section {
                    Text(conversion, format: .number)

                } header: {
                    Text("Results:")
                }
            }
            .navigationBarTitle("Temperature Convertor")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
