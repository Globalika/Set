//
//  ShakeEffect.swift
//  Set
//
//  Created by Volodymyr Seredovych on 26.10.2021.
//

import SwiftUI

struct ShakeEffect: GeometryEffect {
    var amount: CGFloat = 10
    var shakesPerUnit = 3
    var animatableData: CGFloat

    func effectValue(size: CGSize) -> ProjectionTransform {
        ProjectionTransform(CGAffineTransform(translationX:
            amount * sin(animatableData * .pi * CGFloat(shakesPerUnit)),
            y: 0))
    }
}
extension View {
    func shakeEffect(withForce data: CGFloat) -> some View {
        self.modifier(ShakeEffect(animatableData: data))
    }
}
