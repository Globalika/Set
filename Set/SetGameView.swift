//
//  ContentView.swift
//  Set
//
//  Created by Volodymyr Seredovych on 12.10.2021.
//

import SwiftUI

struct SetGameView: View {
    
    @ObservedObject var game: SetGameViewModel
    
    var body: some View {
        VStack {
            Text("My Set Game :)")
            Spacer()
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 65))], content: {
                ForEach(game.cards) {
                    item in Text("tt")
                }
            })
        }
    }
}












































struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = SetGameViewModel()
        SetGameView(game: game)
    }
}
