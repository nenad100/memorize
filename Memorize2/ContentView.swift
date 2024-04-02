//
//  ContentView.swift
//  Memorize2
//
//  Created by Nenad Stojanov on 2.4.24.
//

import SwiftUI

struct ContentView: View {
    let emojis = ["👻","🎃","🕷️","👿","👻"]
    
    var body: some View {
        HStack {
            ForEach(emojis.indices, id: \.self) { index in
                CardView(content: emojis[index])
            }
        }
        .imageScale(.small)
        .foregroundColor(.orange)
        .padding()
        
    }
}

struct CardView: View {
    let content: String
    @State var isFaceUp = true
    
    var body: some View {
        ZStack {
            let base = RoundedRectangle(cornerRadius: 12)
            if (isFaceUp) {
                base.fill(.white)
                base.strokeBorder(lineWidth: 10)
                Text(content).font(.largeTitle)
            } else {
                base.fill() // this is default, just for demonstration
            }
        }
        .onTapGesture {
            isFaceUp.toggle()
        }
    }
}
















#Preview {
    ContentView()
}
