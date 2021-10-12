//
//  SetGame.swift
//  Set
//
//  Created by Volodymyr Seredovych on 12.10.2021.
//

import Foundation


struct SetGameModel <CardContent> {
    private(set) var cards: Array<Card>
    
    mutating func choose(_ card: Card) {
        
    }
    
    init (createCardContent: (Int) -> CardContent) {
        cards = []
        for index in 0..<81 {
            let content = createCardContent(index)
            cards.append(Card(content: content,id: index))
        }
    }
    
    struct Card : Identifiable {
        let isFaceUp = false
        let isMatched = false
        let content: CardContent
        let id: Int
    }
}
