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
    // Track if AddView is being shown
    @State private var showingAddExpense = false

    var body: some View {
        // Create layout for items
        NavigationView {
            List {
                // Identify each expenseItem by its name
                ForEach(expenses.items) { item in
                    HStack {
                        VStack(alignment: .leading) {
                            // Displays the item's name and type
                            Text(item.name)
                                .font(.headline)
                            Text(item.type)
                        }

                        Spacer()
                        // Displays the item's amount
                        Text(item.amount, format: .currency(code: expenses.usrRegionCode))
                            .foregroundColor(expenseColor(price: item.amount))
                    }
                }
                // Delete itames
                .onDelete(perform: removeItems)
            }
            // Set title
            .navigationTitle("iExpense")

            // Add toolbar button
            .toolbar {
                // Button that triggers AddView
                Button {
                    showingAddExpense = true
                } label: {
                    Image(systemName: "plus")
                }
            }
        }
        // Present AddView
        .sheet(isPresented: $showingAddExpense) {
            // Share expenses object with AddView
            AddView(expenses: expenses)
        }
    }

    // Fuction to delete items
    func removeItems(at offsets: IndexSet) {
        expenses.items.remove(atOffsets: offsets)
    }

    // Coloring expenses based off of price
    func expenseColor(price: Double) -> Color {
        if price >= 200 && price < 500 {
            return .orange
        } else if price >= 500 {
            return .red
        }
        return .green
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
