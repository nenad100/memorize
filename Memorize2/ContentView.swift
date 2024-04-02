//
//  ContentView.swift
//  Memorize2
//
//  Created by Nenad Stojanov on 2.4.24.
//

import SwiftUI

struct ContentView: View {
    let haloweenTheme = ["👻","🎃","🕷️","👿","💀","🕸️","🧙‍♀️","🙀","👹","😱","☠️","🍭"];
    let carTheme = ["🚗","🚙","🏎️","🛺","🚕","🛻","🚖","🚔"]
    let trainTheme = ["🚂","🚃","🚝","🚅","🚆","🚇","🚉"]
    @State var emojis: Array<String> = []
    
    @State var cardCount: Int = 4
    
    var body: some View {
        VStack {
            Text("Memorize!")
                .font(.largeTitle)
            ScrollView {
                cards
            }
            Spacer()
            cardCountAdjusters
            Spacer()
            themePickers
        }
        .padding()
    }
    
    var cards: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 120))]) {
            if (emojis.count > 0) {
                ForEach(0..<cardCount, id: \.self) { index in
                    CardView(content: emojis[index])
                        .aspectRatio(2/3, contentMode: .fit)
                }
            }
        }
        .foregroundColor(.orange)
    }
    
    var cardCountAdjusters: some View {
        HStack {
            cardRemover
            Spacer()
            cardAdder
        }
        .imageScale(.large)
        .font(.largeTitle)
    }
    
    func cardCountAdjuster(by offset: Int, symbol: String) -> some View {
        Button(action: {
            cardCount += offset
        }, label: {
            Image(systemName: symbol)
        })
        .disabled(cardCount + offset < 1 || cardCount + offset > emojis.count)
    }
    
    var cardRemover: some View {
        return cardCountAdjuster(by: -1, symbol: "rectangle.stack.badge.minus.fill")
    }
    
    var cardAdder: some View {
        return cardCountAdjuster(by: 1, symbol: "rectangle.stack.badge.plus.fill")
    }
    
    var themePickers: some View {
        HStack {
            themeButton(themeEmojis: carTheme, symbol: "car", btnLabel: "Vehicles")
            Spacer()
            themeButton(themeEmojis: haloweenTheme, symbol: "moon", btnLabel: "Halloween")
            Spacer()
            themeButton(themeEmojis: trainTheme, symbol: "train.side.front.car",
            btnLabel: "Trains")
        }
    }
    
    func themeButton(themeEmojis: Array<String>, symbol: String, btnLabel: String) -> some View {
       Button( action: {
           emojis = (themeEmojis + themeEmojis).shuffled();
       }, label: {
           VStack {
               Image(systemName: symbol)
                   .imageScale(.large)
                   .font(.largeTitle)
               Text(btnLabel)
           }
       })
    }
}

struct CardView: View {
    let content: String
    @State var isFaceUp = false
    
    var body: some View {
        ZStack {
            let base = RoundedRectangle(cornerRadius: 12)
            Group {
                base.fill(.white)
                base.strokeBorder(lineWidth: 2)
                Text(content).font(.largeTitle)
            }
            .opacity(isFaceUp ? 1 : 0)
            base.fill().opacity(isFaceUp ? 0 : 1)
        }
        .onTapGesture {
            isFaceUp.toggle()
        }
    }
}
















#Preview {
    ContentView()
}
