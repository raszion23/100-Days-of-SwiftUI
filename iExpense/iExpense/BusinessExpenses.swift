//
//  BusinessExpenses.swift
//  iExpense
//
//  Created by Raszion23 on 5/16/22.
//

import Foundation

// Class that will store an array of the ExpenseItems inside a single object called "businessItems".
class BusinessExpenses: ObservableObject {
    // Where all the expense items are structs are stored
    @Published var businessItems = [ExpenseItem]() {
        // When an item gets added or removed, the changes are written out
        didSet {
            // Convert data to JSON by encoding items array
            if let encoded = try? JSONEncoder().encode(businessItems) {
                // Writing data to UserDefaults using the key "Items"
                UserDefaults.standard.set(encoded, forKey: "Business Items")
            }
        }
    }

    // Custom initializer
    init() {
        // Attempt to read the "Items" key from UserDefaults
        if let savedItems = UserDefaults.standard.data(forKey: "Business Items") {
            // Create an instace of JSON Decoder to go from JSON to Swift object
            // Convert data from UserDefault into an array of ExpenseItem objects
            if let decodedItems = try? JSONDecoder().decode([ExpenseItem].self, from: savedItems) {
                // If it works, assign the resulting arrat to items
                businessItems = decodedItems
                // Exit
                return
            }
        }
        // If failed, set items to be an empty array
        businessItems = []
    }
    
    // Use user's preferred currency
    let usrRegionCode = Locale.current.currencyCode!
}
