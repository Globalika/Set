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
                
                let height = height / 3.5
                let width = width / 2
                
                let left = CGPoint(x: midX - width / 1.35, y: midY)
                let pass_1 = CGPoint(x: midX - width / 3.2,
                                     y: midY + height / 3.5)
                let pass_2 = CGPoint(x: midX + width / 6,
                                     y: midY + height / 3)
                let right = CGPoint(x: midX + width / 1.35, y: midY)
                let pass_3 = CGPoint(x: midX + width / 3.2,
                                     y: midY - height / 3.5)
                let pass_4 = CGPoint(x: midX - width / 6,
                                     y: midY - height / 3)
                path.move(to: left)
                path.addCurve(to: pass_1,
                           control1: left,
                           control2: CGPoint(x: midX - width / 1.05,
                                             y: midY + height / 1.4))
                path.addCurve(to: pass_2,
                           control1: pass_1,
                           control2: CGPoint(x: midX + width / 10,
                                             y: midY + height / 4.5))
                path.addCurve(to: right,
                           control1: pass_2,
                           control2: CGPoint(x: midX + width / 2,
                                             y: midY + height / 2.4))
                path.addCurve(to: pass_3,
                           control1: right,
                           control2: CGPoint(x: midX + width / 1.05,
                                             y: midY - height / 1.4))
                path.addCurve(to: pass_4,
                           control1: pass_3,
                           control2: CGPoint(x: midX - width / 10,
                                             y: midY - height / 4.5))
                path.addCurve(to: left,
                           control1: pass_4,
                           control2: CGPoint(x: midX - width / 2,
                                             y: midY - height / 2.4))
            }
            .shapeModifier(color, shadling)
        }
    }
}
