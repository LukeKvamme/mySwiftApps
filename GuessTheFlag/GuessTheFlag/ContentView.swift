//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Luke Kvamme on 3/22/23.
//

import SwiftUI

struct ContentView: View {
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var showingScore = false
    @State private var scoreTitle = ""
    
    @State private var currentScore = 0
    @State private var roundNumber = 0
    @State private var isReset = false
    var goodGame = "GG's"
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.blue, .red]), startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            VStack {
                Spacer()
                
                Text("Guess the Flag")
                    .font(.largeTitle.weight(.bold))
                    // .font(.largeTitle.bold()) is a bold shortcut
                    .foregroundColor(.white)
                
                VStack(spacing: 15) {
                    VStack {
                        Text("Tap the flag of")
                            .foregroundColor(.secondary)
                            .font(.subheadline.weight(.heavy))
                        
                        Text(countries[correctAnswer])
                            .foregroundColor(.secondary)
                            .font(.largeTitle.weight(.semibold))
                    }
                    ForEach(0..<3) { number in
                        Button {
                            flagTapped(number)
                        } label: {
                            Image(countries[number])
                                .renderingMode(.original)
                                .clipShape(Capsule())
                                .shadow(radius: 5)
                            
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(RoundedRectangle(cornerRadius:20))
                
                Spacer()
                
                Text("Round Number \(roundNumber) / 8")
                    .foregroundColor(.white)
                    .font(.title.bold())
                
                Spacer()
                
                Text("Score: \(currentScore)")
                    .foregroundColor(.white)
                    .font(.title.bold())
                Spacer()
            } .padding()
            
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action: askQuestion)
        } message: {
            Text("Your score is \(currentScore)")
        }
        .alert(goodGame, isPresented: $isReset) {
            Button("Play Again", action: reset)
        } message: {
            Text("Your score for that game was \(currentScore)")
        }
        
    }
    
    func reset() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        
        currentScore = 0
        roundNumber = 0
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
    
    func flagTapped(_ number: Int) {
        roundNumber += 1
        if number == correctAnswer {
            scoreTitle = "Correct, plus 1"
            currentScore += 1
        } else {
            scoreTitle = "You're an idiot, that's \(countries[number])! \n minus 1 🤣 \n 🤡 🤡"
            currentScore -= 1
        }
        showingScore = true
        if roundNumber == 8 {
            isReset = true
        }
    }
        
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
