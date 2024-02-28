//
//  ContentView.swift
//  SquiggleDesigner
//
//  Created by Christoph Braß on 29.01.24.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.colorScheme) var colorScheme
    
    @State private var isShowingOverlay = false

    @State private var showCurvePoints: Bool = true
    @State private var showControlPoints: Bool = true
    
    @ObservedObject var squiggleViewModel: SquiggleViewModel
    
    var body: some View {
        ZStack {
        VStack {
            Text("Squiggle Designer").font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
            Divider()
            ZStack {
                SquiggleShape(controlPoints: squiggleViewModel.controlPoints, curvePoints: squiggleViewModel.curvePoints)
                    .stroke(colorScheme == .dark ? Color.white : Color.black, lineWidth: 3)
                pointDrawer
            }
            Spacer()
            appMenu
        }
        if isShowingOverlay {
            Color.black
                .opacity(0.5)
                .edgesIgnoringSafeArea(.all)
                .onTapGesture {
                    self.isShowingOverlay = false
                }
            
            VStack {
                NavigationView {
                    List {
                        Section(header: Text("Control Points")) {
                            ForEach(0..<squiggleViewModel.controlPoints.count, id: \.self) { index in
                                HStack {
                                    Text("Point \(index + 1)")
                                    Spacer()
                                    Text("x: \(Int(squiggleViewModel.controlPoints[index].x)), y: \(Int(squiggleViewModel.controlPoints[index].y))")
                                }
                            }
                        }
                        
                        Section(header: Text("Curve Points")) {
                            ForEach(0..<squiggleViewModel.curvePoints.count, id: \.self) { index in
                                HStack {
                                    Text("Point \(index + 1)")
                                    Spacer()
                                    Text("x: \(Int(squiggleViewModel.curvePoints[index].x)), y: \(Int(squiggleViewModel.curvePoints[index].y))")
                                }
                            }
                        }
                    }
                    .navigationTitle("Positions")
                }
                Button("Close") {
                    self.isShowingOverlay = false
                }
                .padding()
                .background(Color.white)
                .cornerRadius(8)
            }
            .padding()
            .background(Color.white)
            .cornerRadius(16)
            .padding()
        }
    }
    }
    
    private var pointDrawer: some View {
        ZStack {
            ForEach(0..<squiggleViewModel.curvePoints.count, id: \.self ) { index in
                Circle()
                    .foregroundStyle(Color.green)
                    .frame(width: 20, height: 10)
                    .position(squiggleViewModel.curvePoints[index])
                    .gesture(
                        DragGesture()
                            .onChanged { value in
                                squiggleViewModel.updateCurvePoint(at: index, with: value.location)
                            }
                    )
                  
            }.opacity(showCurvePoints ? 1 : 0)
            
            
            ForEach(0..<squiggleViewModel.controlPoints.count, id: \.self ) { index in
                
                Circle()
                    .foregroundStyle(squiggleViewModel.colors[index])
                    .frame(width: 20, height: 10)
                    .position(squiggleViewModel.controlPoints[index])
                    .gesture(
                        DragGesture()
                            .onChanged { value in
                                squiggleViewModel.updateControlPoint(at: index, with: value.location)
                            }
                    )
                
            }.opacity(showControlPoints ? 1 : 0)
        }
    }
    
    private var appMenu: some View {
        HStack{
            Menu ("Options",systemImage: "plus.app") {
                Button("Reset") {
                    squiggleViewModel.resetSquiggle()
                }
                Button("Log positions") {
                    self.isShowingOverlay = true
                }
                Button("Toggle curve points") {
                    showCurvePoints.toggle()
                }
                Button("Toggle control points") {
                    showControlPoints.toggle()
                }
            }
            
            .padding()
            .font(.largeTitle)
        }
    }
}

#Preview {
    ContentView(squiggleViewModel: SquiggleViewModel())
}
