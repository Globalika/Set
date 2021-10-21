//
//  PathExtention.swift
//  Set
//
//  Created by Volodymyr Seredovych on 18.10.2021.
//

import SwiftUI

extension Path {
    func shapeModifier(_ color: Color, _ shadling: EShadling) -> some View {
        self
            .if(shadling == EShadling.solid) { $0.stroke() }
            else: { $0.opacity(shadling.rawValue) }
            .foregroundColor(color)
    }
}
