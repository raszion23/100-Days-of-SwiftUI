//
//  Mission.swift
//  Moonshot
//
//  Created by Raszion23 on 5/19/22.
//

import Foundation

// Convert the data from mission.JSON into a mission data type and crewrole data type
// Codable: Allow data to be convereted from and to JSON
// Identifiable: Allows the mission data type to be identified uniquely
// Nested CrewRole struct into Mission struct
struct Mission: Codable, Identifiable {
    struct CrewRole: Codable {
        let name: String
        let role: String
    }

    let id: Int
    let launchDate: String?
    let crew: [CrewRole]
    let description: String
}
