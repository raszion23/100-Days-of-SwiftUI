//
//  ContentView.swift
//  Milestone Rock Paper Scissors
//
//  Created by Raszion23 on 1/3/22.
//

import SwiftUI

struct GameImage: View {
    var image: String
    
    var body: some View {
        Image(image)
            .resizable(resizingMode: .stretch)
            .aspectRatio(contentMode: .fit)
            .frame(width: 180, height: 180)
        
            .shadow(radius: 10)
    }
}

struct ContentView: View {
    @State private var moves = ["rock", "paper", "scissors"].shuffled()
    @State private var randomMoves = Int.random(in: 0 ... 2)
    
    @State private var userMove = 0
    @State private var scoreTitle = ""
    @State private var userScore = 0
    @State private var cpuScore = 0
    @State private var round = 0
    @State private var finalWinner = ""
    
    @State private var showingWinner = false
    @State private var showingRestartGame = false
    
    var body: some View {
        ZStack {
            RadialGradient(stops: [
                .init(color: Color(red: 0.6, green: 0.2, blue: 0.1), location: 0.6),
                .init(color: Color(red: 0.2, green: 0.56, blue: 0.75), location: 0.6),
            ], center: .bottomLeading, startRadius: 100, endRadius: 600)
                .ignoresSafeArea()
            
            VStack {
                Spacer()
            
                Text("Rock - Paper - Scissors")
                    .font(.largeTitle.bold())
                    
                Spacer()
                Spacer()
            
                VStack(spacing: 15) {
                    ForEach(0 ..< 3) { number in
                        Button {
                            userMove = number
                            whoWon(cpu: randomMoves, user: userMove)
                            
                        } label: {
                            GameImage(image: moves[number])
                        }
                    }
                }
            
                Spacer()
            
                HStack(spacing: 200) {
                    VStack {
                        Text("YOU ")
                        Text("\(userScore)")
                    }
                
                    VStack {
                        Text("CPU ")
                        Text("\(cpuScore)")
                    }
                }
                .font(.body.bold())
               
                Spacer()
            
                Text("Round: \(round)")
                    .font(.body.bold())
            
                Spacer()
            }
            .foregroundColor(.white)
            .padding()
        }
        .alert(scoreTitle, isPresented: $showingWinner) {
            Button("Continue", action: newRound)
        }
        .alert("Winner is:", isPresented: $showingRestartGame) {
            Button("Reset", action: restartGame)
        } message: {
            Text("\(finalWinner)")
                .font(.title.bold())
        }
    }
    
    func whoWon(cpu: Int, user: Int) {
        if cpu == 0 && user == 2 || cpu == 1 && user == 0 || cpu == 2 && user == 1 {
            scoreTitle = "CPU won!"
            cpuScore += 1
        
        } else if user == 0 && cpu == 2 || user == 1 && cpu == 0 || user == 2 && cpu == 1 {
            scoreTitle = "You won!"
            userScore += 1
            
        } else if cpu == user {
            scoreTitle = "Draw!"
        }
        
        if userScore > cpuScore {
            finalWinner = "YOU!"
        } else if userScore < cpuScore {
            finalWinner = "CPU!"
        } else {
            finalWinner = "DRAW!"
        }
        
        if round < 10 {
            showingWinner = true
        } else {
            showingRestartGame = true
        }
    }
    
    func newRound() {
        moves.shuffle()
        randomMoves = Int.random(in: 0 ... 2)
        round += 1
    }
    
    func restartGame() {
        userScore = 0
        cpuScore = 0
        round = 0
        newRound()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
