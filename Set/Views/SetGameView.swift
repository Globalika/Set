//
//  ContentView.swift
//  Set
//
//  Created by Volodymyr Seredovych on 12.10.2021.
//

import SwiftUI

struct SetGameView: View {
    @State private var disabled                 = false
    @State private var isGameFinished           = false
    @State private var isSetResolved: Bool      = false
    @State private var cardsToRemove: [Int]     = []
    @State private var dealt                    = Set<Int>()
    @ObservedObject var game: SetGameViewModel
    @Namespace private var dealingNamespace
    var body: some View {
        VStack {
            upperPanel
            ZStack {
                Group {
                    Spacer()
                    EndGameView(isPresented: $isGameFinished)
                    Spacer()
                } .opacity(isGameFinished ? 1 : 0)
                boardBody.opacity(isGameFinished ? 0 : 1)
            }
            lowerPanel
        }
        .padding(3)
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
    var upperPanel: some View {
        HStack {
            Spacer()
            cardsLeft
            Spacer()
            newGame
            Spacer()
        }
    }
    var cardsLeft: some View {
        Text("cards left: \(game.cardsOnBoard.count + game.cardsInDeck.count)")
            .foregroundColor(.blue)
    }
    var newGame: some View {
        Button("New Game") {
            game.restart()
            dealt = []
            withAnimation { isGameFinished.toggle() }
            disabled = false
        }
    }
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
    private func zIndex(of card: SetGameViewModel.Card) -> Double {
        Double(card.id)
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
            .zIndex(zIndex(of: card))
            .onTapGesture {
                withAnimation {
                    game.choose(card)
                    cardsToRemove.append(card.id)
                }
                if game.isThereASet(), !isSetResolved {
                    isSetResolved.toggle()
                }
                if !game.isThereASet(), isSetResolved {
                    cardsToRemove.removeLast()
                    for (card, id) in zip(game.cardsInDiscardPile.filter({ cardsToRemove.contains($0.id) }),
                        0..<3) {
                        withAnimation(threeCardsAnimation(id)) {
                            deal(card)
                        }
                    }
                    for (card, id) in zip(game.cardsOnBoard.filter({ !isDealt($0) }),
                        0..<3) {
                        withAnimation(threeCardsAnimation(id)) {
                            deal(card)
                        }
                    }
                    cardsToRemove.removeAll()
                    isSetResolved.toggle()
                }
                if game.cardsInDeck.isEmpty, game.cardsOnBoard.isEmpty {
                    withAnimation { isGameFinished.toggle() }
                }
            }
        }
    }
    var deckBody: some View {
        ZStack {
            ForEach(game.cardsInDeck + game.cardsOnBoard.filter { !isDealt($0) }) { card in
                CardView(card: card, isFaceUp: false)
                    .matchedGeometryEffect(id: card.id, in: dealingNamespace)
                    .transition(AnyTransition.asymmetric(insertion: .opacity, removal: .identity))
                    .zIndex(zIndex(of: card))
            }
            .frame(width: CardConstants.undealtWidth,
                   height: CardConstants.undealtHeight)
        }
        .onTapGesture {
            withAnimation {
                if game.cardsInDeck.count == 81 {
                    game.dealStartCards()
                } else {
                    if !game.dealThreeMore() {
                        return
                    }
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
            ForEach(game.lastDiscarded()) { card in
                CardView(card: card)
                    .matchedGeometryEffect(id: card.id, in: dealingNamespace)
                    .transition(AnyTransition.asymmetric(insertion: .identity, removal: .opacity))
                    .zIndex(zIndex(of: card))
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
