//
//  Expenses.swift
//  iExpense
//
//  Created by Raszion23 on 5/16/22.
//

import Foundation

// Class that will store an array of the ExpenseItems inside a single object called "items".
class Expenses: ObservableObject {
    @Published var items = [ExpenseItem]()
}
