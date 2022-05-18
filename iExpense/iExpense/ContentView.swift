//
//  ContentView.swift
//  iExpense
//
//  Created by Raszion23 on 5/15/22.
//

import SwiftUI

struct ContentView: View {
    // Create instance of Personal Expenses class
    @StateObject var personalExpenses = PersonalExpenses()
    // Create instance of Personal Expenses class
    @StateObject var businessExpenses = BusinessExpenses()
    // Track if AddView is being shown
    @State private var showingAddExpense = false

    var body: some View {
        // Create layout for items
        NavigationView {
            List {
                // Section for personal expenses
                Section("Personal Expenses") {
                    // Identify each expenseItem by its name
                    ForEach(personalExpenses.personalItems) { item in
                        HStack {
                            VStack(alignment: .leading) {
                                // Displays the item's name and type
                                Text(item.name)
                                    .font(.headline)
                                Text(item.type)
                            }

                            Spacer()
                            // Displays the item's amount
                            Text(item.amount, format: .currency(code: personalExpenses.usrRegionCode))
                                .foregroundColor(expenseColor(price: item.amount))
                        }
                    }
                    // Delete itames
                    .onDelete(perform: removePersonalItems)
                }

                // Section for Business expenses
                Section("Business Expenses") {
                    // Identify each expenseItem by its name
                    ForEach(businessExpenses.businessItems) { item in
                        HStack {
                            VStack(alignment: .leading) {
                                // Displays the item's name and type
                                Text(item.name)
                                    .font(.headline)
                                Text(item.type)
                            }

                            Spacer()
                            // Displays the item's amount
                            Text(item.amount, format: .currency(code: businessExpenses.usrRegionCode))
                                .foregroundColor(expenseColor(price: item.amount))
                        }
                    }
                    // Delete itames
                    .onDelete(perform: removeBusinessItems)
                }
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
            AddView(expenses: personalExpenses, businessExpenses: businessExpenses)
        }
    }

    // Fuction to delete personal items
    func removePersonalItems(at offsets: IndexSet) {
        personalExpenses.personalItems.remove(atOffsets: offsets)
    }

    // Fuction to delete businessrsonal items
    func removeBusinessItems(at offsets: IndexSet) {
        businessExpenses.businessItems.remove(atOffsets: offsets)
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
