//
//  DiamondShape.swift
//  Set
//
//  Created by Volodymyr Seredovych on 12.10.2021.
//

import SwiftUI

struct Diamond: Shape {
    func path(in rect: CGRect) -> Path {
        let diagonalLong = rect.height / 2
        let diagonalShort = rect.width / 1.5
        
        let left = CGPoint(
            x: rect.midX - diagonalShort / 2,
            y: rect.midY)
        let right = CGPoint(
            x: rect.midX + diagonalShort / 2,
            y: rect.midY)
        let up = CGPoint(
            x: rect.midX,
            y: rect.midY - diagonalLong / 2)
        let down = CGPoint(
            x: rect.midX,
            y: rect.midY + diagonalLong / 2)
        
        var p = Path()
        p.move(to: left)
        p.addLine(to: down)
        p.addLine(to: right)
        p.addLine(to: up)
        p.addLine(to: left)
        
        return p
    }
}
