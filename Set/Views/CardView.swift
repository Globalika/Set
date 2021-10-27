//
//  CardView.swift
//  Set
//
//  Created by Volodymyr Seredovych on 27.10.2021.
//

import SwiftUI

struct CardView: View {
    let card: SetGameViewModel.Card
    var isFaceUp: Bool = true
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                let shape = RoundedRectangle(cornerRadius: DrawingConstrants.cornerRadius)
                shape.fill().foregroundColor(.gray)
                if isFaceUp {
                    VStack {
                        ForEach((0..<card.content.numberOfShape.rawValue), id: \.self) { index in
                            card.content.shape.getShape(
                                shapeParams: ShapeParamsModel(
                                    color: card.content.color.rawValue,
                                    center: CGPoint(x: geometry.size.width / 2,
                                                    y: geometry.size.width *
                                                    getYCenterCoef(card.content.numberOfShape.rawValue,
                                                                   index)),
                                    shadling: card.content.shadling,
                                    size: geometry.size))
                        }
                    }
                }
            }
        }
    }
    private func getYCenterCoef(_ numberOfCCards: Int, _ currentNumber: Int) -> CGFloat {
        switch numberOfCCards {
        case 1:
            return CGFloat(Float(currentNumber / 2) + Float(0.75))
        case 2:
            return CGFloat(Float(currentNumber / 4) + Float(0.35))
        default:
            return CGFloat(Float(currentNumber / 6) + Float(0.22))
        }
    }
    private struct DrawingConstrants {
        static let cornerRadius: CGFloat = 15
        static let lineWidth: CGFloat = 1
    }
}
