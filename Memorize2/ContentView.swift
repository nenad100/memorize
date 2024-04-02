//
//  ContentView.swift
//  Memorize2
//
//  Created by Nenad Stojanov on 2.4.24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        HStack {
            CardView(isFaceUp: true)
            CardView()
            CardView()
            CardView()
        }
        .imageScale(.small)
        .foregroundColor(.orange)
        .padding()
        
    }
}

struct CardView: View {
    @State var isFaceUp = false
    
    var body: some View {
        ZStack {
            let base = RoundedRectangle(cornerRadius: 12)
            if (isFaceUp) {
                base.fill(.white)
                base.strokeBorder(lineWidth: 10)
                Text("👻").font(.largeTitle)
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
