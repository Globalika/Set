//
//  PathExtention.swift
//  Set
//
//  Created by Volodymyr Seredovych on 18.10.2021.
//

import SwiftUI

extension Path {
    func shapeModifier(_ color: Color,_ shadling: EShadling) -> some View {
        self
            .if(shadling == EShadling.solid)
                    { $0.stroke() }
            else: { $0.opacity(shadling.rawValue) }
            .foregroundColor(color)
    }
}

//extension Path {
//    @ViewBuilder func `if`<TrueContent: View, FalseContent: View>
//                            (_ condition: Bool,
//                             then contentTrue: (Self) -> TrueContent,
//                             else contentFalse: (Self) -> FalseContent)
//    -> some View
//    {
//         if condition {
//             contentTrue(self)
//         } else {
//             contentFalse(self)
//         }
//     }
//}

//extension Path {
//    @ViewBuilder func shapeModifier2
//    (_ color: Color,_ shadling: EShadling) -> some View {
//
//        if(shadling == EShadling.solid) {
//            self.stroke().foregroundColor(color)
//        } else {
//            self.opacity(shadling.rawValue).foregroundColor(color)
//        }
//    }
//}
