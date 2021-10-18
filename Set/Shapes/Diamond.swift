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
    init(_ color: Color,_ center: CGPoint,_ shadling: EShadling,
         _ height: CGFloat,_ width: CGFloat)
    {
        self.color = color
        self.center = center
        self.shadling = shadling
        self.height = height
        self.width = width
    }
    
    var body: some View {
        GeometryReader { geometry in
            Path { path in
                let midX = center.x
                let midY = center.y
                
                let diagonalLong = height / 3.8
                let diagonalShort = width / 1.1
                
                let left = CGPoint(
                    x: midX - diagonalShort / 2,
                    y: midY)
                let right = CGPoint(
                    x: midX + diagonalShort / 2,
                    y: midY)
                let up = CGPoint(
                    x: midX,
                    y: midY - diagonalLong / 2)
                let down = CGPoint(
                    x: midX,
                    y: midY + diagonalLong / 2)
                
                path.move(to: left)
                path.addLine(to: down)
                path.addLine(to: right)
                path.addLine(to: up)
                path.addLine(to: left)
            }
            .shapeModifier(color, shadling)
        }
    }
        
}
