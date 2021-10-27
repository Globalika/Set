//
//  EndGameView.swift
//  Set
//
//  Created by Volodymyr Seredovych on 27.10.2021.
//

import SwiftUI

struct EndGameView: View {
    @Binding var isPresented: Bool
    var body: some View {
        Text("Congratulation")
            .foregroundColor(.orange)
            .font(.largeTitle)
            .rotationEffect(Angle.degrees(isPresented ? 0 : 360))
            .animation(Animation.default.repeat(while: isPresented).speed(0.7), value: isPresented)
    }
}
