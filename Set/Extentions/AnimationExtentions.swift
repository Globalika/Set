//
//  AnimationExtentions.swift
//  Set
//
//  Created by Volodymyr Seredovych on 27.10.2021.
//

import SwiftUI

extension Animation {
    func `repeat`(while expression: Bool, _ autoreverses: Bool = false) -> Animation {
        if expression {
            return self.repeatForever(autoreverses: autoreverses)
        } else {
            return self
        }
    }
}
