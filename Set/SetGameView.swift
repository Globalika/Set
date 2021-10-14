//
//  ContentView.swift
//  Set
//
//  Created by Volodymyr Seredovych on 12.10.2021.
//

import SwiftUI

struct SetGameView: View {
    
    @State private var disabled = false
    @ObservedObject var game: SetGameViewModel
    
    var body: some View {
        VStack {
            HStack {
                Button { disabled = !game.dealThreeMore() } label: {
                    Text("Deal 3 More Cards")
                } .disabled( disabled )
                Spacer()
                Text("cards left: \(game.cards.count + game.deck.count)")
                Spacer()
                Button {game.restart() } label: {
                    Text("New Game")
                }
            }
                .foregroundColor(.blue)
            AspectVGrid(items: game.cards, aspectRatio: 2/3) {
                card in
                ZStack{
                    CardView(card: card)
                        .padding(card.isSelected ? 1 : 4)
                        .onTapGesture {
                            game.choose(card)
                        }
                    if let isSet = game.isThereASet() {
                        if card.isSelected {
                            Image(systemName: isSet ? "checkmark" : "xmark").foregroundColor(.black)
                        }
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
                    shape.fill().foregroundColor(.white)
                    VStack {
                        ForEach((0..<card.content.numberOfShape.rawValue)
                                , id: \.self) {
                            index in
                            if(card.content.shadling == EShadling.solid) {
                                switch card.content.shape {
                                case .diamond:
                                    Diamond()
                                        .stroke()
                                        .font(Font.system(size : geometry.size.width))
                                        .foregroundColor(card.content.color.rawValue)
                                case .squiggle:
                                    Squiggle()
                                        .stroke()
                                        .font(Font.system(size : geometry.size.width))
                                        .foregroundColor(card.content.color.rawValue)
                                case .oval:
                                    Oval()
                                        .stroke()
                                        .font(Font.system(size : geometry.size.width))
                                        .foregroundColor(card.content.color.rawValue)
                                }
                            } else {
                                card.content.shape.getShape()
                                    .font(Font.system(size : geometry.size.width))
                                    .foregroundColor(card.content.color.rawValue)
                                    .opacity(card.content.shadling.rawValue)
                            }
                        }
                    }
            }
        }
    }
    private struct DrawingConstrants {
        static let cornerRadius: CGFloat = 20
        static let lineWidth: CGFloat = 1
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = SetGameViewModel()
        SetGameView(game: game)
            .preferredColorScheme(.dark)
    }
}
