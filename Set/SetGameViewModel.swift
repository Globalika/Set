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
    var cards: [Card] {
        model.cards
    }
    var deck: [Card] {
        model.deck
    }
    func choose(_ card: Card) {
        model.choose(card)
    }
    func restart() {
        let array = SetGameContent.themeArray.shuffled()
        self.model = SetGameModel { index in array[index] }
    }
    func dealThreeMore() -> Bool {
        model.dealThreeMore()
    }
    func isThereASet() -> Bool {
        model.isThereASet
    }
    func isSetNotFull() -> Bool {
        model.isSetNotFull
    }
}
