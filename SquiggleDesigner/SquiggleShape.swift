//
//  Squiggle.swift
//  SquiggleDesigner
//
//  Created by Christoph Braß on 29.01.24.
//

import SwiftUI

struct SquiggleShape: Shape {
    var controlPoints: [CGPoint]
    var points: [CGPoint]
   
    func path(in rect: CGRect) -> Path {
        var path = Path()

        path.move(to: points[0])
        path.addCurve(to: points[1],
                      control1: controlPoints[0], control2: controlPoints[1])
        path.addCurve(to: points[2],
                      control1: controlPoints[2], control2: controlPoints[3])
        path.addCurve(to: points[3],
                      control1: controlPoints[4], control2: controlPoints[5])
        path.addCurve(to: points[4],
                      control1: controlPoints[6], control2: controlPoints[7])
        path.addCurve(to: points[0],
                      control1: controlPoints[8], control2: controlPoints[9])
        
        return path
               
    }
}
