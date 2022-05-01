//
//  ContentView.swift
//  ViewModifierChallange
//
//  Created by Raszion23 on 1/2/22.
//

import SwiftUI

struct TitleFont: ViewModifier {
    func body(content: Content) -> some View {
       content
            .font(.largeTitle)
            .foregroundColor(.blue)
    }
}

extension View {
    func titleFont() -> some View {
        modifier(TitleFont())
    }
}

struct ContentView: View {
    var body: some View {
        Text("Hello, world!")
            .titleFont()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
