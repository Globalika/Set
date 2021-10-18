//
//  SetGame.swift
//  Set
//
//  Created by Volodymyr Seredovych on 12.10.2021.
//

import Foundation

struct SetGameModel {
    private(set) var deck: Array<Card>
    private(set) var cards: Array<Card>
    
    private var setForCheck: Set<Int> = Set<Int>()
    var isThereASet : Bool?
    
    mutating func choose(_ card: Card) {
        if let choosenIndex = cards.firstIndex(where: { $0.id == card.id })
        {
            if let isSet = isThereASet {
                if isSet {
                    for index in setForCheck {
                        cards[index].isSelected = false
                    }
                    if deck.isEmpty {
                        for index in setForCheck.sorted(by: >) {
                            cards.remove(at: index)
                        }
                    } else {
                        for index in setForCheck {
                            cards[index] = deck.first!
                            deck.remove(at: deck.startIndex)
                        }
                    }
                    isThereASet = nil
                    setForCheck.removeAll()
                    return
                } else {
                    for index in setForCheck {
                        cards[index].isSelected = false
                    }
                }
                isThereASet = nil
                setForCheck.removeAll()
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
                if let indexToRemove = setForCheck.firstIndex(of: choosenIndex){
                    setForCheck.remove(at: indexToRemove)
                }
                cards[choosenIndex].isSelected = false
            }
        }
    }
    
    mutating func dealThreeMore() -> Bool {
        if !deck.isEmpty {
            if let isSet = isThereASet {
                if isSet {
                    for index in setForCheck {
                        cards[index].isSelected = false
                        cards.remove(at: index)
                        cards.append(deck.first!)
                        deck.remove(at: deck.startIndex)
                    }
                    isThereASet = nil
                } else {
                    for _ in 0..<3 {
                        cards.append(deck.first!)
                        deck.remove(at: deck.startIndex)
                    }
                }
            } else {
                for _ in 0..<3{
                    cards.append(deck.first!)
                    deck.remove(at: deck.startIndex)
                }
            }
            return true
        }
        return false
    }
    
    init (createCardContent: (Int) -> SetGameContent) {
        deck = []
        for index in 0..<81 {
            let content = createCardContent(index)
            deck.append(Card(content: content,id: index))
        }
        cards = []
        for index in 0..<12 {
            cards.append(deck[index])
            deck.remove(at: index)
        }
    }
    
    func isSet(_ setForCheck: [Int]) -> Bool {
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
    
    struct Card : Identifiable {
        var isSelected = false
        let content: SetGameContent
        let id: Int
    }
}
