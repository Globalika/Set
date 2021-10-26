//
//  SetGameViewModel.swift
//  Set
//
//  Created by Volodymyr Seredovych on 12.10.2021.
//

import SwiftUI

class SetGameViewModel: ObservableObject {
    typealias Card = SetGameModel.Card
    @Published private var model: SetGameModel
    init() {
        let array = SetGameContent.themeArray.shuffled()
        self.model = SetGameModel { index in array[index] }
    }
    var cardsInDeck: [Card] {
        model.cardsInDeck
    }
    var cardsOnBoard: [Card] {
        model.cardsOnBoard
    }
    var cardsInDiscardPile: [Card] {
        model.cardsInDiscardPile
    }
    func choose(_ card: Card) {
        model.choose(card)
    }
    func restart() {
        let array = SetGameContent.themeArray.shuffled()
        self.model = SetGameModel { index in array[index] }
    }
    func dealThreeMore() {
        model.dealThreeMore()
    }
    func dealStartCards() {
        model.dealStartCards()
    }
    func isThereASet() -> Bool {
        model.isThereASet
    }
    func isSetNotFull() -> Bool {
        model.isSetNotFull
    }
}
