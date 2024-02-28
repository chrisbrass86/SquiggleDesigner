//
//  SquiggleViewModel.swift
//  SquiggleDesigner
//
//  Created by Christoph Braß on 27.02.24.
//
import SwiftUI

class SquiggleViewModel: ObservableObject {
    @Published private var squiggle: Squiggle
    
    init() {
        self.squiggle = defaultSquiggle
    }
    
    var controlPoints: [CGPoint] {
        squiggle.controlPoints
    }
    
    var curvePoints: [CGPoint] {
        squiggle.curvePoints
    }
    
    var colors: [Color] {
        squiggle.colors
    }
    
    func updateControlPoint(at index: Int, with point: CGPoint) {
        squiggle.controlPoints[index] = point
    }
    
    func updateCurvePoint(at index: Int, with point: CGPoint) {
        squiggle.curvePoints[index] = point
    }
    
    
    func resetSquiggle() {
        squiggle = defaultSquiggle
    }
}
