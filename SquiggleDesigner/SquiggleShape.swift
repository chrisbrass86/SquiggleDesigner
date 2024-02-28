//
//  SquiggleShape.swift
//  SquiggleDesigner
//
//  Created by Christoph Braß on 29.01.24.
//

import SwiftUI

struct SquiggleShape: Shape {
    var controlPoints: [CGPoint]
    var curvePoints: [CGPoint]
   
    func path(in rect: CGRect) -> Path {
        var path = Path()

        path.move(to: curvePoints[0])
        path.addCurve(to: curvePoints[1],
                      control1: controlPoints[0], control2: controlPoints[1])
        path.addCurve(to: curvePoints[2],
                      control1: controlPoints[2], control2: controlPoints[3])
        path.addCurve(to: curvePoints[3],
                      control1: controlPoints[4], control2: controlPoints[5])
        path.addCurve(to: curvePoints[4],
                      control1: controlPoints[6], control2: controlPoints[7])
        path.addCurve(to: curvePoints[0],
                      control1: controlPoints[8], control2: controlPoints[9])
        return path
    }
}
