//
//  AddView.swift
//  iExpense
//
//  Created by Raszion23 on 5/17/22.
//

import SwiftUI

// View for adding new expense items
struct AddView: View {
    // Share existing Personal Expense object from ContentView
    @ObservedObject var expenses: PersonalExpenses
    // Share existing Business Expense object from ContentView
    @ObservedObject var businessExpenses: BusinessExpenses
    // Dismiss AddView
    @Environment(\.dismiss) var dismiss
    
    // Name of expense item
    @State private var name = ""
    // Type of expense item
    @State private var type = ""
    // Cost of expense item
    @State private var amount = 0.0
    
    // Array that holds different types of expense
    let types = ["Business", "Personal"]
    
    var body: some View {
        // UI Layout
        NavigationView {
            Form {
                // Input for name of expense item
                TextField("Name", text: $name)
                
                // Select the type of expense
                Picker("Type", selection: $type) {
                    ForEach(types, id: \.self) {
                        Text($0)
                    }
                }
                
                // Input for the amount of the expense item set in USD
                TextField("Amount", value: $amount, format: .currency(code: expenses.usrRegionCode))
                    .keyboardType(.decimalPad)
            }
            // Title
            .navigationTitle("Add new expense")
            
            // Button that creates an ExpenseItem and add it to the expenses items array
            .toolbar {
                Button("Save") {
                    let item = ExpenseItem(name: name, type: type, amount: amount)
                    
                    if item.type == "Personal" {
                        expenses.personalItems.append(item)
                    } else if item.type == "Business" {
                        businessExpenses.businessItems.append(item)
                    }
                    
                    // AddView dismiss itself
                    dismiss()
                }
            }
        }
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView(expenses: PersonalExpenses(), businessExpenses: BusinessExpenses())
    }
}
