//
//  SquiggleShape.swift
//  Set
//
//  Created by Volodymyr Seredovych on 12.10.2021.
//

import SwiftUI

struct Squiggle: View, ShapeParams {
    let color: Color
    let center: CGPoint
    let shadling: EShadling
    var size: CGSize
    init(shapeParams: ShapeParams) {
        self.color = shapeParams.color
        self.center = shapeParams.center
        self.shadling = shapeParams.shadling
        self.size = shapeParams.size
    }
    var body: some View {
        Path { path in
            let midX = center.x
            let midY = center.y
            let height = size.height / 3.5
            let width = size.width / 2
            let left = CGPoint(x: midX - width / 1.35, y: midY)
            let pass1 = CGPoint(x: midX - width / 3.2,
                                 y: midY + height / 3.5)
            let pass2 = CGPoint(x: midX + width / 6,
                                 y: midY + height / 3)
            let right = CGPoint(x: midX + width / 1.35, y: midY)
            let pass3 = CGPoint(x: midX + width / 3.2,
                                 y: midY - height / 3.5)
            let pass4 = CGPoint(x: midX - width / 6,
                                 y: midY - height / 3)
            path.move(to: left)
            path.addCurve(to: pass1,
                          control1: left,
                          control2: CGPoint(x: midX - width / 1.05,
                                            y: midY + height / 1.4))
            path.addCurve(to: pass2,
                          control1: pass1,
                          control2: CGPoint(x: midX + width / 10,
                                            y: midY + height / 4.5))
            path.addCurve(to: right,
                          control1: pass2,
                          control2: CGPoint(x: midX + width / 2,
                                            y: midY + height / 2.4))
            path.addCurve(to: pass3,
                          control1: right,
                          control2: CGPoint(x: midX + width / 1.05,
                                            y: midY - height / 1.4))
            path.addCurve(to: pass4,
                          control1: pass3,
                          control2: CGPoint(x: midX - width / 10,
                                            y: midY - height / 4.5))
            path.addCurve(to: left,
                          control1: pass4,
                          control2: CGPoint(x: midX - width / 2,
                                            y: midY - height / 2.4))
        }
        .shapeModifier(color, shadling)
    }
}
