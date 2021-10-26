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
    @Namespace private var dealingNamespace
    var body: some View {
        VStack {
            upperPanel
            boardBody
            lowerPanel
        }
        .padding(3)
    }
    var newGame: some View {
        withAnimation(.linear(duration: 2)) {
            Button("New Game") {
                game.restart()
                dealt = []
                disabled = false
            }
        }
    }
    var cardsLeft: some View {
        Text("cards left: \(game.cardsOnBoard.count + game.cardsInDeck.count)")
            .foregroundColor(.blue)
    }
    var upperPanel: some View {
        HStack {
            Spacer()
            cardsLeft
            Spacer()
            newGame
            Spacer()
        }
    }
    var lowerPanel: some View {
        HStack {
            Spacer()
            deckBody
            Spacer()
            discardPileBody
            Spacer()
        }
    }
    @State private var dealt = Set<Int>()
    private func deal(_ card: SetGameViewModel.Card) {
        dealt.insert(card.id)
    }
    private func isDealt(_ card: SetGameViewModel.Card) -> Bool {
        dealt.contains(card.id)
    }
    private func dealStartCardsAnimation(for card: SetGameViewModel.Card) -> Animation {
        var delay = 0.0
        if let index = game.cardsOnBoard.firstIndex(where: { $0.id == card.id }) {
            delay = Double(index) * CardConstants.totalStartCardsDealDuraction / 12
        }
        return Animation.easeInOut(duration: CardConstants.dealDuraction).delay(delay)
    }
    private func threeCardsAnimation(_ id: Int) -> Animation {
        let delay = Double(id) * CardConstants.totalThreeMoreCardsDealDuraction / 3
        return Animation.easeInOut(duration: CardConstants.dealDuraction).delay(delay)
    }
    private func dealAnimation(for card: SetGameViewModel.Card) -> Animation {
        var delay = 0.0
        if let index = game.cardsOnBoard.firstIndex(where: { $0.id == card.id }) {
            delay = Double(index) * CardConstants.totalStartCardsDealDuraction / 81
        }
        return Animation.easeInOut(duration: CardConstants.dealDuraction).delay(delay)
    }
    var boardBody: some View {
        AspectVGrid(items: game.cardsOnBoard, aspectRatio: 2/3) { card in
            Group {
                if isDealt(card) {
                   if card.isSelected {
                        CardView(card: card).overlay(RoundedRectangle(cornerRadius: 15)
                                                        .stroke(
                                                            game.isSetNotFull() ?
                                                            (.white) :
                                                                (game.isThereASet() ?
                                                                    .green :
                                                                        .red),
                                                                lineWidth: 3))
                    } else {
                        CardView(card: card)
                    }
                }
            }
            .matchedGeometryEffect(id: card.id, in: dealingNamespace)
            .transition(AnyTransition.asymmetric(insertion: .identity, removal: .opacity))
            .shakeEffect(withForce: game.isSetNotFull() ? 0 : (game.isThereASet() ? 0 : 1))
            .padding(2)
            .onTapGesture {
                withAnimation {
                    game.choose(card)
                }
            }
        }
    }
    var deckBody: some View {
        ZStack {
            ForEach(game.cardsInDeck + game.cardsOnBoard.filter { !isDealt($0) }) { card in
                CardView(card: card)
                    .matchedGeometryEffect(id: card.id, in: dealingNamespace)
                    .transition(AnyTransition.asymmetric(insertion: .opacity, removal: .identity))
            }
            .frame(width: CardConstants.undealtWidth,
                   height: CardConstants.undealtHeight)
        }
        .onAppear {
            for card in game.cardsOnBoard {
                withAnimation(dealAnimation(for: card)) {
                    deal(card)
                }
            }
        }
        .onTapGesture {
            withAnimation {
                if game.cardsInDeck.count == 81 {
                    game.dealStartCards()
                } else {
                    game.dealThreeMore()
                }
            }
            let cards = game.cardsOnBoard.filter({ !isDealt($0) })
            if cards.count == 12 {
                for card in cards {
                    withAnimation(dealStartCardsAnimation(for: card)) {
                        deal(card)
                    }
                }
            } else {
                for (card, id) in zip(cards, 0..<3) {
                    withAnimation(threeCardsAnimation(id)) {
                        deal(card)
                    }
                }
            }
        }
    }
    var discardPileBody: some View {
        ZStack {
            ForEach(game.cardsInDiscardPile) { card in
                CardView(card: card)
                    .matchedGeometryEffect(id: card.id, in: dealingNamespace)
                    .transition(AnyTransition.asymmetric(insertion: .identity, removal: .opacity))
            }
        }
        .frame(width: CardConstants.undealtWidth,
               height: CardConstants.undealtHeight)
    }
    private struct CardConstants {
        static let aspectRatio: CGFloat = 2/3
        static let dealDuraction: Double = 0.35
        static let totalStartCardsDealDuraction: Double = 2
        static let totalThreeMoreCardsDealDuraction: Double = 1
        static let undealtHeight: CGFloat = 90
        static let undealtWidth = undealtHeight * aspectRatio
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = SetGameViewModel()
        SetGameView(game: game)
            .preferredColorScheme(.dark)
    }
}
