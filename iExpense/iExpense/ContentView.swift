//
//  ContentView.swift
//  iExpense
//
//  Created by Raszion23 on 5/15/22.
//

import SwiftUI

struct ContentView: View {
    // Create instance of Expense class
    @StateObject var expenses = Expenses()

    var body: some View {
        // Create layout for items
        NavigationView {
            List {
                // Identify each expenseItem by its name
                ForEach(expenses.items, id: \.name) { item in
                    // Displays the item's name on the list row
                    Text(item.name)
                }
                // Delete itames
                .onDelete(perform: removeItems)
            }
            // Set title
            .navigationTitle("iExpense")

            // Add toolbar button
            .toolbar {
                // Button that adds an example of ExpenseItem
                Button {
                    let expense = ExpenseItem(name: "Test", type: "Personal", amount: 5)
                    expenses.items.append(expense)
                } label: {
                    Image(systemName: "plus")
                }
            }
        }
    }

    // Fuction to delete items
    func removeItems(at offsets: IndexSet) {
        expenses.items.remove(atOffsets: offsets)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
