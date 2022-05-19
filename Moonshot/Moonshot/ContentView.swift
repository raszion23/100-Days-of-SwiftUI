//
//  ContentView.swift
//  Moonshot
//
//  Created by Raszion23 on 5/19/22.
//

import SwiftUI

struct ContentView: View {
    // Load astronauts.json into dictionary using type annotation
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    // Load missions.json into array using type annotation
    let missions: [Mission] = Bundle.main.decode("missions.json")

    var body: some View {
        Text("\(astronauts.count)")
            .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
