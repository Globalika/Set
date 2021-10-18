//
//  ShapeParams.swift
//  Set
//
//  Created by Volodymyr Seredovych on 18.10.2021.
//

import SwiftUI

protocol ShapeParams {
    var color: Color { get }
    var center: CGPoint { get }
    var shadling: EShadling { get }
    var height: CGFloat { get }
    var width: CGFloat { get }
}
