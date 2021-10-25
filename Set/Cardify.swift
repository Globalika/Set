//
//  Cardify.swift
//  Set
//
//  Created by Volodymyr Seredovych on 24.10.2021.
//

import SwiftUI

struct Cardify: AnimatableModifier {
    init(state: CardState) {
        rotation = (state == .inDeck) ? 0 : 180
    }
    var animatableData: Double {
        get { rotation }
        set { rotation = newValue }
    }
    var rotation: Double
    func body(content: Content) -> some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: DrawingConstants.cornerRadius)
            Group {
            if rotation < 90 {
                content.overlay(shape.fill(.gray))
            } else {
                content
            }
            }//.opacity(rotation < 90 ? 1 : 0)
        }
        .rotation3DEffect(Angle.degrees(rotation), axis: (x: 0, y: 1, z: 0))
    }
    private struct DrawingConstants {
        static let cornerRadius: CGFloat = 20
        static let lineWidth: CGFloat = 3
    }
}

extension View {
    func cardify(state: CardState) -> some View {
        self.modifier(Cardify(state: state))
    }
}
