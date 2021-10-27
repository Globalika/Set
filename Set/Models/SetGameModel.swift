//
//  SetGame.swift
//  Set
//
//  Created by Volodymyr Seredovych on 12.10.2021.
//

import Foundation

struct SetGameModel {
    private(set) var cardsInDeck: [Card]
    private(set) var cardsOnBoard: [Card] = []
    private(set) var cardsInDiscardPile: [Card] = []
    private(set) var lastDiscardedCards: [Card] = []
    private var setForCheck: Set<Int> = []
    var isThereASet: Bool = false
    var isSetNotFull: Bool { setForCheck.count < 3 }
    mutating func choose(_ card: Card) {
        if let choosenIndex = cardsOnBoard.firstIndex(where: { $0.id == card.id }) {
            if setForCheck.count == 3 {
                if setResolving() {
                    return
                }
            }
            if !cardsOnBoard[choosenIndex].isSelected {
                if setForCheck.count < 3 {
                    cardsOnBoard[choosenIndex].isSelected = true
                    setForCheck.insert(choosenIndex)
                }
                if setForCheck.count == 3 {
                    isThereASet = isSet(setForCheck.sorted()) ? true : false
                }
            } else {
                if let indexToRemove = setForCheck.firstIndex(of: choosenIndex) {
                    setForCheck.remove(at: indexToRemove)
                }
                cardsOnBoard[choosenIndex].isSelected = false
            }
        }
    }
    mutating func dealStartCards() {
        cardsOnBoard = []
        for _ in 0..<Constants.startCardsAmount {
            cardsOnBoard.append(cardsInDeck.removeFirst())
        }
    }
    mutating func dealThreeMore() -> Bool {
        if cardsInDeck.isEmpty {
            return false
        }
        for _ in 0..<3 {
            cardsOnBoard.append(cardsInDeck.removeFirst())
        }
        return true
    }
    init (createCardContent: (Int) -> SetGameContent) {
        cardsInDeck = []
        for index in 0..<Constants.uniqueCardsForSetGameAmount {
            let content = createCardContent(index)
            cardsInDeck.append(Card(content: content, id: index))
        }
    }
    private func isSet(_ setForCheck: [Int]) -> Bool {
        if Set([cardsOnBoard[setForCheck[0]].content.shape.rawValue,
                cardsOnBoard[setForCheck[1]].content.shape.rawValue,
                cardsOnBoard[setForCheck[2]].content.shape.rawValue]).count == 2 ||
           Set([cardsOnBoard[setForCheck[0]].content.shadling.rawValue,
                cardsOnBoard[setForCheck[1]].content.shadling.rawValue,
                cardsOnBoard[setForCheck[2]].content.shadling.rawValue]).count == 2 ||
           Set([cardsOnBoard[setForCheck[0]].content.numberOfShape.rawValue,
                cardsOnBoard[setForCheck[1]].content.numberOfShape.rawValue,
                cardsOnBoard[setForCheck[2]].content.numberOfShape.rawValue]).count == 2 ||
           Set([cardsOnBoard[setForCheck[0]].content.color.rawValue,
                cardsOnBoard[setForCheck[1]].content.color.rawValue,
                cardsOnBoard[setForCheck[2]].content.color.rawValue]).count == 2 {
            return false
        }
        return true
    }
    private mutating func setResolving() -> Bool {
        if isThereASet {
            for index in setForCheck {
                cardsOnBoard[index].isSelected = false
            }
            if lastDiscardedCards.count == 3 {
                lastDiscardedCards.removeFirst()
            }
            if cardsInDeck.isEmpty {
                for index in setForCheck.sorted(by: >) {
                    lastDiscardedCards.append(cardsOnBoard.remove(at: index))
                }
            } else {
                for index in setForCheck.sorted(by: >) {
                    if let deckFirstElement = cardsInDeck.first {
                        lastDiscardedCards.append(cardsOnBoard[index])
                        cardsOnBoard[index] = deckFirstElement
                        cardsInDeck.remove(at: cardsInDeck.startIndex)
                    }
                }
            }
            isThereASet = false
            setForCheck.removeAll()
            return true
        } else {
            for index in setForCheck {
                cardsOnBoard[index].isSelected = false
            }
        }
        setForCheck.removeAll()
        return false
    }
    struct Card: Identifiable {
        var isSelected = false
        let content: SetGameContent
        let id: Int
    }
    private struct Constants {
        static let startCardsAmount = 12
        static let uniqueCardsForSetGameAmount = 81
    }
}
