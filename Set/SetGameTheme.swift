//
//  CardDeck.swift
//  Set
//
//  Created by Volodymyr Seredovych on 12.10.2021.
//

import Foundation
import SwiftUI

enum EShape: CaseIterable{
    case diamond, squiggle, oval
}
enum EColor: CaseIterable {
    case red, green, blue
}
enum ENumberOfShapes: Int, CaseIterable {
    case one = 1, two, three
}
enum EShadling: CaseIterable {
    case solid, stripted, open
}
extension EColor : RawRepresentable {
    typealias RawValue = Color

        init?(rawValue: RawValue) {
            switch rawValue {
            case Color.red: self = .red
            case Color.green: self = .green
            case Color.blue: self = .blue
            default:
                return nil
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
    let shape: EShape
    let color: EColor
    let numberOfShape: ENumberOfShapes
    let shadling: EShadling
    init(_ shape: EShape, _ color: EColor, _ numberOfShape: ENumberOfShapes,_ shadling: EShadling) {
        self.shape = shape
        self.color = color
        self.numberOfShape = numberOfShape
        self.shadling = shadling
    }
    static func createArray() -> [SetGameTheme] {
        var array = [SetGameTheme]()
        for shape in EShape.allCases {
            for color in EColor.allCases {
                for shapeNumber in ENumberOfShapes.allCases {
                    for shadling in EShadling.allCases {
                        array.append(SetGameTheme(shape, color, shapeNumber, shadling))
                    }
                }
            }
        }
        return array
    }
    static let themeArray = createArray()
}
