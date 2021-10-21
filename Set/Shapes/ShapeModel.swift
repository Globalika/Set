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
    let size: CGSize
    init(color: Color, center: CGPoint, shadling: EShadling, size: CGSize) {
        self.color = color
        self.center = center
        self.shadling = shadling
        self.size = size
    }
}
