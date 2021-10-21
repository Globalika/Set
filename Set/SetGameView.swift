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
                Button {
                    game.restart()
                    disabled = false
                } label: {
                    Text("New Game")
                }
            } .foregroundColor(.blue)
            AspectVGrid(items: game.cards, aspectRatio: 2/3) { card in
                ZStack {
                    CardView(card: card)
                        .padding(card.isSelected ? 1 : 4)
                        .onTapGesture {
                            game.choose(card)
                        }
                    if !game.isSetNotFull() {
                        if card.isSelected {
                            Image(systemName: game.isThereASet() ? "checkmark" : "xmark")
                                .foregroundColor(.black)
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
                let shape = RoundedRectangle(cornerRadius: DrawingConstrants.cornerRadius)
                shape.fill().foregroundColor(.white)
                VStack {
                    ForEach((0..<card.content.numberOfShape.rawValue), id: \.self) { index in
                        card.content.shape.getShape(
                            shapeParams: ShapeParamsModel(
                                color: card.content.color.rawValue,
                                center: CGPoint(x: geometry.size.width / 2,
                                                y: geometry.size.width *
                                                getYCenterCoef(card.content.numberOfShape.rawValue,
                                                               index)),
                                shadling: card.content.shadling,
                                size: geometry.size))
                            .font(Font.system(size: geometry.size.width))
                    }
                }
            }
        }
    }
    private func getYCenterCoef(_ numberOfCCards: Int, _ currentNumber: Int) -> CGFloat {
        switch numberOfCCards {
        case 1:
            return CGFloat(Float(currentNumber / 2) + Float(0.75))
        case 2:
            return CGFloat(Float(currentNumber / 4) + Float(0.35))
        default:
            return CGFloat(Float(currentNumber / 6) + Float(0.22))
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
