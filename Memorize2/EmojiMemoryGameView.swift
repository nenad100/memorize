//
//  EmojiMemoryGameView.swift
//  Memorize2
//
//  Created by Nenad Stojanov on 2.4.24.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    @ObservedObject var viewModel: EmojiMemoryGame
    
    private let aspectRation: CGFloat = 2/3
    
    var body: some View {
        VStack{
            ScrollView {
                cards
                    .animation(.default, value: viewModel.cards)
            }
            Button("Shuffle") {
                viewModel.shuffle()
            }
        }
        .padding()
    }
    
    private var cards: some View {
        GeometryReader { geometry in
            let gridItemSize = gridItemWithThatFits(
                count: viewModel.cards.count,
                size: geometry.size,
                atAspectRatio: aspectRation)
            LazyVGrid(columns: [GridItem(.adaptive(minimum: gridItemSize), spacing: 0)], spacing: 0) {
                ForEach(viewModel.cards) { card in
                    CardView(card)
                        .aspectRatio(aspectRation, contentMode: .fit)
                        .padding(4)
                        .onTapGesture {
                            viewModel.choose(card)
                        }
                }
            }
            .foregroundColor(.orange)
        }
    }
}

private func gridItemWithThatFits(
    count: Int,
    size: CGSize,
    atAspectRatio aspectRatio: CGFloat
) -> CGFloat {
    let count = CGFloat(count)
    let geometryAspectRatio = (size.height / size.width) * 0.5
    var columnCount = 1.0
    repeat {
        let width = size.width / columnCount
        let height = (width / aspectRatio) * geometryAspectRatio
        
        let rowCount = (count / columnCount).rounded(.up)

        if rowCount * height < size.height {
            return (size.width / columnCount).rounded(.down)
        }
        columnCount += 1
    } while columnCount < count
    
    return min(size.width / count, size.height * aspectRatio / geometryAspectRatio).rounded(.down)
}

struct CardView: View {
    let card: MemoryGame<String>.Card
    
    init(_ card: MemoryGame<String>.Card) {
        self.card = card
    }
    
    var body: some View {
        ZStack {
            let base = RoundedRectangle(cornerRadius: 12)
            Group {
                base.fill(.white)
                base.strokeBorder(lineWidth: 2)
                Text(card.content)
                    .font(.system(size: 200))
                    .minimumScaleFactor(0.01)
                    .aspectRatio(1, contentMode: .fit)
            }
                .opacity(card.isFaceUp ? 1 : 0)
            base.fill()
                .opacity(card.isFaceUp ? 0 : 1)
        }
        .opacity(card.isFaceUp || !card.isMatched ? 1 : 0)
    }
}
















#Preview {
    EmojiMemoryGameView(viewModel: EmojiMemoryGame())
}
