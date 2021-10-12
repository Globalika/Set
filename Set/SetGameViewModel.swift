//
//  SetGameViewModel.swift
//  Set
//
//  Created by Volodymyr Seredovych on 12.10.2021.
//

import SwiftUI

class SetGameViewModel : ObservableObject {
    typealias Card = SetGameModel<SetGameTheme>.Card
   
    @Published private var model: SetGameModel<SetGameTheme> = SetGameModel<SetGameTheme>
        { index in array[index] }
    
    static let array = SetGameTheme.themeArray
    static func createArray() -> [SetGameTheme] {
        self.array
    }
    
    var cards: Array<Card> {
        model.cards
    }
}
