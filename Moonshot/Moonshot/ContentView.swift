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

    // Define an adaptive column layer
    let columns = [GridItem(.adaptive(minimum: 150))]

    var body: some View {
        // Create UI
        NavigationView {
            ScrollView {
                LazyVGrid(columns: columns) {
                    ForEach(missions) { mission in
                        NavigationLink {
                            Text("Detail View")
                        } label: {
                            VStack {
                                Image(mission.image)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 100, height: 100)
                                    .padding()

                                VStack {
                                    Text(mission.displayName)
                                        .font(.headline)
                                        .foregroundColor(.white)
                                    Text(mission.formattedLaunchDate)
                                        .font(.caption)
                                        .foregroundColor(.white.opacity(0.5))
                                }
                                .padding(.vertical)
                                .frame(maxWidth: .infinity)
                                .background(.lightBackground)
                            }
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(.lightBackground)
                            )
                        }
                    }
                }
                .padding([.horizontal, .bottom])
            }
            .navigationTitle("Moonshot")
            .background(.darkBackground)
            .preferredColorScheme(.dark)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
