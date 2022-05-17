//
//  ExpenseItem.swift
//  iExpense
//
//  Created by Raszion23 on 5/16/22.
//

import Foundation

// Struct that defines a single item of expense
// Identifiable means "this object can be identifed uniquely
// Codable allows the ability to archive all the exisiting expense items ready to be stored
struct ExpenseItem: Identifiable, Codable {
    var id = UUID()
    let name: String
    let type: String
    let amount: Double
}
