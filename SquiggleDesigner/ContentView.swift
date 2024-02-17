//
//  ContentView.swift
//  SquiggleDesigner
//
//  Created by Christoph Braß on 29.01.24.
//

import SwiftUI

struct SheetView: View {
    @Environment(\.dismiss) var dismiss
    
    var controlPoints: [CGPoint]
    var curvePoints: [CGPoint]
    
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Control Points")) {
                    ForEach(0..<controlPoints.count, id: \.self) { index in
                        HStack {
                            Text("Point \(index + 1)")
                            Spacer()
                            Text("x: \(Int(controlPoints[index].x)), y: \(Int(controlPoints[index].y))")
                        }
                    }
                }
                
                Section(header: Text("Curve Points")) {
                    ForEach(0..<curvePoints.count, id: \.self) { index in
                        HStack {
                            Text("Point \(index + 1)")
                            Spacer()
                            Text("x: \(Int(curvePoints[index].x)), y: \(Int(curvePoints[index].y))")
                        }
                    }
                }
            }
            .navigationTitle("Positions")
        }
    }
}



struct ContentView: View {
    @Environment(\.colorScheme) var colorScheme
    
    @State private var showingSheet = false

    @State static private var startControlPoints: [CGPoint] = [
        CGPoint(x: 21, y: 321), CGPoint(x: 101, y: 285),
        CGPoint(x: 290, y: 376), CGPoint(x: 303, y: 261),
        CGPoint(x: 373, y: 354), CGPoint(x: 318, y: 470),
        CGPoint(x: 177, y: 430), CGPoint(x: 158, y: 415),
        CGPoint(x: 92, y: 437), CGPoint(x: 47, y: 498)]
    
    @State static private var startCurvePoints: [CGPoint] = [CGPoint(x: 30, y: 421), CGPoint(x: 172, y: 318), CGPoint(x: 343, y: 310), CGPoint(x: 211, y: 440), CGPoint(x: 123, y: 425)]
    
    @State private var controlPoints: [CGPoint] = startControlPoints

    @State private var curvePoints: [CGPoint] = startCurvePoints
    
    @State private var colors: [Color] = [Color.red, Color.red, Color.blue, Color.blue, Color.orange, Color.orange, Color.purple, Color.purple, Color.yellow, Color.yellow]

    @State private var showCurvePoints: Bool = true
    @State private var showControlPoints: Bool = true
    
    var body: some View {
        VStack {
            Text("Squiggle Designer").font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
            Divider()
            GeometryReader { geometry in
                ZStack {
                    Squiggle(controlPoints: controlPoints, points: curvePoints)
                        .stroke(colorScheme == .dark ? Color.white : Color.black, lineWidth: 3)
                    pointDrawer
                }
            }
            Spacer()
            Divider()
           appMenu
        }
    }
    
    private var pointDrawer: some View {
        ZStack {
            ForEach(0..<curvePoints.count, id: \.self ) { index in
                Circle()
                    .foregroundStyle(Color.green)
                    .frame(width: 20, height: 10)
                    .position(curvePoints[index])
                    .gesture(
                        DragGesture()
                            .onChanged { value in
                                curvePoints[index] = value.location
                            }
                    )
                  
            }.opacity(showCurvePoints ? 1 : 0)
            
            
            ForEach(0..<controlPoints.count, id: \.self ) { index in
                
                Circle()
                    .foregroundStyle(colors[index])
                    .frame(width: 20, height: 10)
                    .position(controlPoints[index])
                    .gesture(
                        DragGesture()
                            .onChanged { value in
                                controlPoints[index] = value.location
                            }
                    )
                
            }.opacity(showControlPoints ? 1 : 0)
        }
    }
    
    private var appMenu: some View {
        HStack{
            Button("Reset") {
                controlPoints = ContentView.startControlPoints
                curvePoints = ContentView.startCurvePoints
            }
            Spacer()
            Button("Log positions") {
                showingSheet.toggle()
            }
            .sheet(isPresented: $showingSheet) {
                SheetView(controlPoints: controlPoints, curvePoints: curvePoints)
            }
            Spacer()
            Button("Toggle curve points") {
                showCurvePoints.toggle()
            }
            Spacer()
            Button("Toggle control points") {
                showControlPoints.toggle()
            }
            
        }
        .padding()
        .font(.subheadline)
    }
}

#Preview {
    ContentView()
}
