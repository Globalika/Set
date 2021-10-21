//
//  OvalShape.swift
//  Set
//
//  Created by Volodymyr Seredovych on 13.10.2021.
//

import SwiftUI

struct Oval: View, ShapeParams {
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
            let leftCenter = CGPoint(x: midX - midX / 3,
                                     y: midY)
            let rightCenter = CGPoint(x: midX + midX / 3,
                                      y: midY)
            let radius = min(size.width/1.3, size.height/1.3) / 4
            let start = CGPoint(x: midX - midX / 3,
                                y: midY - radius)
            path.move(to: start)
            path.addArc(center: leftCenter,
                        radius: radius,
                        startAngle: Angle(degrees: -90),
                        endAngle: Angle(degrees: 90),
                        clockwise: true)
            path.addLine(to: CGPoint(x: midX + midX / 3,
                                     y: midY + radius))
            path.addArc(center: rightCenter,
                        radius: radius,
                        startAngle: Angle(degrees: 90),
                        endAngle: Angle(degrees: 270),
                        clockwise: true)
            path.addLine(to: start)
        }
        .shapeModifier(color, shadling)
    }
}
