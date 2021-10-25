//
//  SetGame.swift
//  Set
//
//  Created by Volodymyr Seredovych on 12.10.2021.
//

import Foundation

struct SetGameModel {
    private(set) var cards: [Card]
    private var setForCheck: Set<Int> = []
    var isThereASet: Bool = false
    var isSetNotFull: Bool { setForCheck.count < 3 }
    var lastIndexInUse: Int = 0
    mutating func choose(_ card: Card) {
        if let choosenIndex = cards.firstIndex(where: { $0.id == card.id }), card.cardState == .inUse {
            if setForCheck.count == 3 {
                setResolving()
            }
            if cards[choosenIndex].cardState == .inDiscardPile {
                return
            }
            if !cards[choosenIndex].isSelected {
                if setForCheck.count < 3 {
                    cards[choosenIndex].isSelected = true
                    setForCheck.insert(choosenIndex)
                }
                if setForCheck.count == 3 {
                    isThereASet = isSet(setForCheck.sorted()) ? true : false
                }
            } else {
                if let indexToRemove = setForCheck.firstIndex(of: choosenIndex) {
                    setForCheck.remove(at: indexToRemove)
                }
                cards[choosenIndex].isSelected = false
            }
        }
    }
    mutating func dealThreeMore() -> Bool {
        if lastIndexInUse < cards.count-1 {
            for index in lastIndexInUse...lastIndexInUse+3 {
                cards[index].isSelected = false
                cards[index].cardState = .inUse
                lastIndexInUse = index
            }
            return false
        }
        return true
    }
    mutating func dealStartCards() {
        for index in 0..<12 {
            cards[index].cardState = .inUse
            lastIndexInUse = index
        }
    }
    init (createCardContent: (Int) -> SetGameContent) {
        cards = []
        for index in 0..<81 {
            let content = createCardContent(index)
            cards.append(Card(content: content, id: index))
        }
    }
    private func isSet(_ setForCheck: [Int]) -> Bool {
        if Set([cards[setForCheck[0]].content.shape.rawValue,
                cards[setForCheck[1]].content.shape.rawValue,
                cards[setForCheck[2]].content.shape.rawValue]).count == 2 ||
           Set([cards[setForCheck[0]].content.shadling.rawValue,
                cards[setForCheck[1]].content.shadling.rawValue,
                cards[setForCheck[2]].content.shadling.rawValue]).count == 2 ||
           Set([cards[setForCheck[0]].content.numberOfShape.rawValue,
                cards[setForCheck[1]].content.numberOfShape.rawValue,
                cards[setForCheck[2]].content.numberOfShape.rawValue]).count == 2 ||
           Set([cards[setForCheck[0]].content.color.rawValue,
                cards[setForCheck[1]].content.color.rawValue,
                cards[setForCheck[2]].content.color.rawValue]).count == 2 {
            return false
        }
        return true
    }
    func getLastInUseIndex() -> Int {
        lastIndexInUse
    }
    private mutating func setResolving() {
        for index in setForCheck {
            cards[index].isSelected = false
        }
        if isThereASet {
            if cards.filter({$0.cardState == .inDeck}).count != 0 {
                for index in setForCheck {
                    cards[index].cardState = .inDiscardPile
                    lastIndexInUse += 1
                    cards[lastIndexInUse].cardState = .inUse
                    cards.swapAt(index, lastIndexInUse)
                }
            } else {
                for index in setForCheck {
                    cards[index].cardState = .inDiscardPile
                }
            }
            isThereASet = false
            setForCheck.removeAll()
            return
        }
        setForCheck.removeAll()
    }
    struct Card: Identifiable {
        var isSelected = false
        var cardState: CardState = .inDeck
        let content: SetGameContent
        let id: Int
    }
}

enum CardState {
    case inDeck, inUse, inDiscardPile
}
