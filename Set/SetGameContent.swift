//
//  CardDeck.swift
//  Set
//
//  Created by Volodymyr Seredovych on 12.10.2021.
//

import Foundation
import SwiftUI

enum EShape: String, CaseIterable {
    case diamond, squiggle, oval
    func getShape(shapeParams: ShapeParams) -> AnyView {
        switch self {
        case .diamond:
            return AnyView(Diamond(shapeParams: shapeParams))
        case .squiggle:
            return AnyView(Squiggle(shapeParams: shapeParams))
        case .oval:
            return AnyView(Oval(shapeParams: shapeParams))
        }
    }
}
enum EColor: CaseIterable {
    case red, green, blue
}
enum ENumberOfShapes: Int, CaseIterable {
    case one = 1, two, three
}
enum EShadling: Double, CaseIterable {
    case solid = 0, stripted = 0.4, open = 1
}
extension EColor: RawRepresentable {
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

struct SetGameContent {
    var shape: EShape
    var color: EColor
    var numberOfShape: ENumberOfShapes
    var shadling: EShadling
    init(_ shape: EShape,
         _ color: EColor,
         _ numberOfShape: ENumberOfShapes,
         _ shadling: EShadling) {
        self.shape = shape
        self.color = color
        self.numberOfShape = numberOfShape
        self.shadling = shadling
    }
    static var themeArray: [SetGameContent] = {
        var array: [SetGameContent] = []
        for shape in EShape.allCases {
            for color in EColor.allCases {
                for shapeNumber in ENumberOfShapes.allCases {
                    for shadling in EShadling.allCases {
                        array.append(SetGameContent(shape,
                                                    color,
                                                    shapeNumber,
                                                    shadling))
                    }
                }
            }
        }
        return array
    }()
}
