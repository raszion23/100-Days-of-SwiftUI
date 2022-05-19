//
//  Bundle-Decodable.swift
//  Moonshot
//
//  Created by Raszion23 on 5/19/22.
//

import Foundation

// Convert json into data
extension Bundle {
    // Function that uses generics to take in a file and returns a data type
    // Codable: Allow data to be convereted from and to JSON
    func decode<T: Codable>(_ file: String) -> T {
        // Find path of file
        guard let url = self.url(forResource: file, withExtension: nil) else {
            // Error if file cannot be located
            fatalError("Failed to locate \(file) in bundle.")
        }
        
        // Load file into an instance of Data
        guard let data = try? Data(contentsOf: url) else {
            // Error if file fails to load from bundle
            fatalError("Failed to load \(file) from bundle.")
        }
        
        // Create instance of JSONDecoder
        let decoder = JSONDecoder()
        
        // Pass data through JSONDecoder
        guard let loaded = try? decoder.decode(T.self, from: data) else {
            // Error if file failed to decode
            fatalError("Failed to decode \(file) from bundle.")
        }
        
        // If successful
        return loaded
    }
}
