//
//  ShapeModels.swift
//  Set
//
//  Created by Volodymyr Seredovych on 20.10.2021.
//

import SwiftUI

struct ShapeParamsModel: ShapeParams {
    let color: Color
    let center: CGPoint
    let shadling: EShadling
    let height: CGFloat
    let width: CGFloat
    init(color: Color, center: CGPoint, shadling: EShadling, height: CGFloat, width: CGFloat) {
        self.color = color
        self.center = center
        self.height = height
        self.width = width
        self.shadling = shadling
    }
}
