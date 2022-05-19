//
//  Astronaut.swift
//  Moonshot
//
//  Created by Raszion23 on 5/19/22.
//

import Foundation

// Convert the data from astronauts.JSON into an astronaut data type
// Codable: Allow data to be convereted from and to JSON
// Identifiable: Allows the astronaut data type to be identified uniquely
struct Astronaut: Codable, Identifiable {
    let id: String
    let name: String
    let description: String
}
