//
//  CardDeck.swift
//  Set
//
//  Created by Volodymyr Seredovych on 12.10.2021.
//

import Foundation
import SwiftUI

enum Shape: CaseIterable{
    case diamond, squiggle, oval
}
enum Color: CaseIterable {
    case red, green, blue
}
enum NumberOfShapes: Int, CaseIterable {
    case one = 1, two, three
}
enum Shadling: CaseIterable {
    case solid, stripted, open
}
extension Color : RawRepresentable {
    typealias RawValue = Color

        init?(rawValue: RawValue) {
            switch rawValue {
            case Color.red: self = .red
            case Color.green: self = .green
            case Color.blue: self = .blue
            }
        }

        var rawValue: RawValue {
            switch self {
            case .red: return Color.red
            case .green: return Color.green
            case .blue: return Color.blue
            }
        }
}

struct SetGameTheme {
    let shape: Shape
    let color: Color
    let numberOfShape: NumberOfShapes
    let shadling: Shadling
    init(_ shape: Shape, _ color: Color, _ numberOfShape: NumberOfShapes,_ shadling: Shadling) {
        self.shape = shape
        self.color = color
        self.numberOfShape = numberOfShape
        self.shadling = shadling
    }
    static func createArray() -> [SetGameTheme] {
        var array = [SetGameTheme]()
        for shape in Shape.allCases {
            for color in Color.allCases {
                for shapeNumber in NumberOfShapes.allCases {
                    for shadling in Shadling.allCases {
                        array.append(SetGameTheme(shape, color, shapeNumber, shadling))
                    }
                }
            }
        }
        return array
    }
    static let themeArray = createArray()
}
