//
//  ViewExtention.swift
//  Set
//
//  Created by Volodymyr Seredovych on 18.10.2021.
//
import SwiftUI

extension View {
    @ViewBuilder func `if`<TrueContent: View, FalseContent: View> (_ condition: Bool,
                                                                   then contentTrue: (Self) -> TrueContent,
                                                                   else contentFalse: (Self) -> FalseContent) -> some View {
        // swiftlint:disable:previous line_length
        if condition {
            contentTrue(self)
        } else {
            contentFalse(self)
        }
     }
}
