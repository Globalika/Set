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
            gameBody
            lowerPanel
        }
        .padding(3)
    }
    var newGame: some View {
        Button {
            game.restart()
            dealt = []
            discarded = []
            disabled = false
        } label: {
            Text("New Game")
        }
    }
    var cardsLeft: some View {
        Text("cards left: \(game.cards.filter({ $0.cardState != .inDiscardPile }).count)")
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
    private func isUndealt(_ card: SetGameViewModel.Card) -> Bool {
        !dealt.contains(card.id)
    }
    @State private var discarded: [Int] = []
    private func discard(_ card: SetGameViewModel.Card) {
        dealt.remove(card.id)
        discarded.append(card.id)
    }
    private func isUndiscarded(_ card: SetGameViewModel.Card) -> Bool {
        !discarded.contains(card.id)
    }
    private func dealStartCardsAnimation(for card: SetGameViewModel.Card) -> Animation {
        var delay = 0.0
        if let index = game.cards.firstIndex(where: { $0.id == card.id }) {
            delay = Double(index) * CardConstants.totalStartCardsDealDuraction / 12
        }
        return Animation.easeInOut(duration: CardConstants.dealDuraction).delay(delay)
    }
    private func threeCardsAnimation(_ id: Int) -> Animation {
        let delay = Double(id) * CardConstants.totalThreeMoreCardsDealDuraction / 3
        return Animation.easeInOut(duration: CardConstants.dealDuraction).delay(delay)
    }
    private func zIndex(of card: SetGameViewModel.Card) -> Double {
        -Double(game.cards.firstIndex(where: { $0.id == card.id }) ?? 0)
    }
    @State private var swapIncomingCards: [Int] = []
    @State private var swapOutgoingCards: [Int] = []
    @State private var isSetResoled: Bool = false
    var gameBody: some View {
        AspectVGrid(items: game.cards.filter({ dealt.contains($0.id) }), aspectRatio: 2/3) { card in
            ZStack {
                Group {
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
                .matchedGeometryEffect(id: card.id, in: dealingNamespace)
                .transition(AnyTransition.asymmetric(insertion: .identity, removal: .scale))
                .padding(2)
                .zIndex(zIndex(of: card))
                .onTapGesture {
                    withAnimation {
                        game.choose(card)
                        swapOutgoingCards.append(card.id)
                    }
                    if game.isThereASet(), !isSetResoled {
                        isSetResoled.toggle()
                    }
                    if !game.isThereASet(), isSetResoled {
                        swapOutgoingCards = swapOutgoingCards.dropLast()
                        for (card, id) in zip(game.cards.filter({ index in
                            swapOutgoingCards.contains(where: { $0 == index.id }) }),
                                              (0...2)) {
                            withAnimation(threeCardsAnimation(id)) {
                                discard(card)
                            }
                        }
                        if game.cards.filter({ $0.cardState == .inDeck }).count != 0 {
                            for (card, id) in zip(game.cards.filter({ index in
                                swapIncomingCards.contains(where: { $0 == index.id }) }), (0...2)) {
                                withAnimation(threeCardsAnimation(id)) {
                                    deal(card)
                                }
                            }
                            swapIncomingCards = []
                            var nextIndex = game.getLastInUseIndex() + 1
                            for _ in 0...2 {
                                swapIncomingCards.append(nextIndex)
                                nextIndex += 1
                            }
                        }
                        swapOutgoingCards = []
                        isSetResoled.toggle()
                    }
                }
            }
        }
    }
    var deckBody: some View {
        ZStack {
            ForEach(game.cards.filter({ isUndealt($0) && isUndiscarded($0) })) { card in
                CardView(card: card)
                    .matchedGeometryEffect(id: card.id, in: dealingNamespace)
                    .transition(AnyTransition.asymmetric(insertion: .opacity, removal: .scale))
                    .zIndex(zIndex(of: card))
            }
        }
        .frame(width: CardConstants.undealtWidth,
               height: CardConstants.undealtHeight)
        .onTapGesture {
            swapIncomingCards = []
            let isStartCards = (game.cards.filter({$0.cardState == .inDeck}).count == 81)
            if isStartCards {
                game.dealStartCards()
                for card in game.cards.filter({$0.cardState == .inUse}) {
                    withAnimation(dealStartCardsAnimation(for: card)) {
                        deal(card)
                    }
                }
            } else {
                disabled = game.dealThreeMore()
                for (card, id) in zip(game.cards.filter({$0.cardState == .inUse}).suffix(3), (0...2)) {
                    withAnimation(threeCardsAnimation(id)) {
                        deal(card)
                    }
                }
            }
            var nextIndex = game.getLastInUseIndex() + 1
            for _ in 0...2 {
                swapIncomingCards.append(nextIndex)
                nextIndex += 1
            }
        }
        .disabled( disabled )
    }
    var discardPileBody: some View {
        ZStack {
            ForEach(game.cards.filter({ discarded.contains($0.id) })) { card in
                CardView(card: card)
                    .matchedGeometryEffect(id: card.id, in: dealingNamespace)
                    .transition(AnyTransition.asymmetric(insertion: .identity, removal: .scale))
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

struct CardView: View {
    let card: SetGameViewModel.Card
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                let shape = RoundedRectangle(cornerRadius: DrawingConstrants.cornerRadius)
                shape.fill().foregroundColor(.gray)
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
                    }
                }
            }
            .cardify(state: card.cardState)
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
        static let cornerRadius: CGFloat = 15
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
