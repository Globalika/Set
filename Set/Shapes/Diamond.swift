//
//  DiamondShape.swift
//  Set
//
//  Created by Volodymyr Seredovych on 12.10.2021.
//

import SwiftUI

struct Diamond: View, ShapeParams {
    let color: Color
    let center: CGPoint
    let shadling: EShadling
    let height: CGFloat
    let width: CGFloat
    init(shapeParams: ShapeParams) {
        self.color = shapeParams.color
        self.center = shapeParams.center
        self.shadling = shapeParams.shadling
        self.height = shapeParams.height
        self.width = shapeParams.width
    }
    var body: some View {
        Path { path in
            let midX = center.x
            let midY = center.y
            let diagonalLong = height / 3.8
            let diagonalShort = width / 1.1
            let left = CGPoint(x: midX - diagonalShort / 2,
                               y: midY)
            let right = CGPoint(x: midX + diagonalShort / 2,
                                y: midY)
            let upp = CGPoint(x: midX,
                             y: midY - diagonalLong / 2)
            let down = CGPoint(x: midX,
                               y: midY + diagonalLong / 2)
            path.move(to: left)
            path.addLine(to: down)
            path.addLine(to: right)
            path.addLine(to: upp)
            path.addLine(to: left)
        }
        .shapeModifier(color, shadling)
    }
}
