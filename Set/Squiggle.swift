//
//  SquiggleShape.swift
//  Set
//
//  Created by Volodymyr Seredovych on 12.10.2021.
//

import SwiftUI

struct Squiggle: Shape {
    func path(in rect: CGRect) -> Path {
        let height = rect.height / 1.5
        let width = rect.width / 2.3
        
        let left = CGPoint(x: rect.midX - width / 1.35, y: rect.midY)
        let pass_1 = CGPoint(x: rect.midX - width / 3.2,
                             y: rect.midY + height / 3.5)
        let pass_2 = CGPoint(x: rect.midX + width / 6,
                             y: rect.midY + height / 3)
        let right = CGPoint(x: rect.midX + width / 1.35, y: rect.midY)
        let pass_3 = CGPoint(x: rect.midX + width / 3.2,
                             y: rect.midY - height / 3.5)
        let pass_4 = CGPoint(x: rect.midX - width / 6,
                             y: rect.midY - height / 3)
        var p = Path()
        p.move(to: left)
        p.addCurve(to: pass_1,
                   control1: left,
                   control2: CGPoint(x: rect.midX - width / 1.05,
                                     y: rect.midY + height / 1.4))
        p.addCurve(to: pass_2,
                   control1: pass_1,
                   control2: CGPoint(x: rect.midX + width / 10,
                                     y: rect.midY + height / 4.5))
        p.addCurve(to: right,
                   control1: pass_2,
                   control2: CGPoint(x: rect.midX + width / 2,
                                     y: rect.midY + height / 2.4))
        p.addCurve(to: pass_3,
                   control1: right,
                   control2: CGPoint(x: rect.midX + width / 1.05,
                                     y: rect.midY - height / 1.4))
        p.addCurve(to: pass_4,
                   control1: pass_3,
                   control2: CGPoint(x: rect.midX - width / 10,
                                     y: rect.midY - height / 4.5))
        p.addCurve(to: left,
                   control1: pass_4,
                   control2: CGPoint(x: rect.midX - width / 2,
                                     y: rect.midY - height / 2.4))
//
        return p
        
    }
}
