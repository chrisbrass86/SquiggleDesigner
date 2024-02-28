//
//  Squiggle.swift
//  SquiggleDesigner
//
//  Created by Christoph Braß on 27.02.24.
//

import SwiftUI

struct Squiggle {
    var controlPoints: [CGPoint]
    var curvePoints: [CGPoint]
    var colors: [Color]
}

let defaultSquiggle = Squiggle(
    controlPoints: defaultControlPoints,
    curvePoints: defaultCurvePoints,
    colors: defaultColors
)

let defaultControlPoints = [CGPoint(x: 21, y: 321), CGPoint(x: 101, y: 285),
    CGPoint(x: 290, y: 376), CGPoint(x: 303, y: 261),
    CGPoint(x: 373, y: 354), CGPoint(x: 318, y: 470),
    CGPoint(x: 177, y: 430), CGPoint(x: 158, y: 415),
    CGPoint(x: 92, y: 437), CGPoint(x: 47, y: 498) ]

let defaultCurvePoints = [CGPoint(x: 30, y: 421), CGPoint(x: 172, y: 318), CGPoint(x: 343, y: 310), CGPoint(x: 211, y: 440), CGPoint(x: 123, y: 425)]

let defaultColors = [Color.red, Color.red, Color.blue, Color.blue, Color.orange, Color.orange, Color.purple, Color.purple, Color.yellow, Color.yellow]
