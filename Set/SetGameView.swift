//
//  ContentView.swift
//  Set
//
//  Created by Volodymyr Seredovych on 12.10.2021.
//

import SwiftUI

struct SetGameView: View {
    
    @ObservedObject var game: SetGameViewModel
    
    var body: some View {
        VStack {
            Text("My Set Game :)")
            AspectVGrid(items: game.cards, aspectRatio: 2/3) {
                card in
                if !card.isFaceUp {
                    Rectangle().opacity(0)
                } else {
                    CardView(card: card)
                        .padding(4)
                        .onTapGesture {
                            game.choose(card)
                        }
                }
            }
        }
    }
}

struct CardView: View {
    let card: SetGameViewModel.Card
    
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                let shape = RoundedRectangle(cornerRadius:  DrawingConstrants.cornerRadius)
                if card.isFaceUp {
                    shape.fill().foregroundColor(.red)
                    shape.strokeBorder(lineWidth: DrawingConstrants.lineWidth)
                    VStack{
                        Diamond().font(Font.system(size : geometry.size.width))
                        Squiggle().font(Font.system(size : geometry.size.width))
                        Oval().font(Font.system(size : geometry.size.width))
                    }
                } else {
                    shape.fill()
                }
            }
        }
    }
    
    
    private struct DrawingConstrants {
        static let cornerRadius: CGFloat = 25
        static let lineWidth: CGFloat = 2.5
    }
}


//diagonalShort: geometry.size.width / 1.5, diagonalLong: geometry.size.height / 4





































struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = SetGameViewModel()
        SetGameView(game: game)
            .preferredColorScheme(.dark)
    }
}
