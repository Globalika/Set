//
//  OvalShape.swift
//  Set
//
//  Created by Volodymyr Seredovych on 13.10.2021.
//

import SwiftUI

struct Oval: Shape {
    func path(in rect: CGRect) -> Path {
        
        let leftCenter = CGPoint(x: rect.midX - rect.midX / 3,
                                 y: rect.midY)
        let rightCenter = CGPoint(x: rect.midX + rect.midX / 3,
                                  y: rect.midY)
        let radius = min(rect.width, rect.height) / 4
        
        let start = CGPoint(x: rect.midX - rect.midX / 3,
                            y: rect.midY - radius)
        var p = Path()
        p.move(to: start)
        p.addArc(
            center: leftCenter,
            radius: radius,
            startAngle: Angle(degrees: -90),
            endAngle: Angle(degrees: 90),
            clockwise: true
        )
        p.addLine(to: CGPoint(x: rect.midX + rect.midX / 3,
                           y: rect.midY + radius))
        p.addArc(
            center: rightCenter,
            radius: radius,
            startAngle: Angle(degrees: 90),
            endAngle: Angle(degrees: 270),
            clockwise: true
        )
        p.addLine(to: start)
        return p
    }
}
