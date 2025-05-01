//
//  TouchTest.swift
//  TestSystem
//
//  Created by Jarl Boyd Roest on 04/03/2025.
//

import SwiftUI

struct TouchTest: View {
    var onComplete: () -> Void = {}
    
    @StateObject private var viewModel = TouchTestM()
    @State private var alertMessage: String = ""
    @State private var showAlert: Bool = false
        
    var body: some View {
            GeometryReader { geometry in
                // Udregn hver celles bredde og højde, så grid'et fylder hele containeren
                let squareWidth = geometry.size.width / CGFloat(viewModel.columns)
                let squareHeight = geometry.size.height / CGFloat(viewModel.rows)
                
                VStack(spacing: 0) {
                    ForEach(0..<viewModel.rows, id: \.self) { row in
                        HStack(spacing: 0) {
                            ForEach(0..<viewModel.columns, id: \.self) { col in
                                ZStack {
                                    // Tegn en ramme for hvert felt
                                    Rectangle()
                                        .stroke(Color.gray, lineWidth: 1)
                                        .frame(width: squareWidth, height: squareHeight)
                                    
                                    // Hvis feltet er berørt, vis en ny farve 
                                    if viewModel.touched[row][col] {
                                        Theme.bubblegum.mainColor
                                    }
                                }
                            }
                        }
                    }
                }
                // Tilføj en DragGesture, der opdaterer viewModel løbende
                .gesture(
                    DragGesture(minimumDistance: 0)
                        .onChanged { value in
                            // Beregn hvilken celle der bliver berørt ud fra dragens position
                            let col = Int(value.location.x / squareWidth)
                            let row = Int(value.location.y / squareHeight)
                            if row >= 0 && row < viewModel.rows && col >= 0 && col < viewModel.columns {
                                viewModel.markTouched(row: row, col: col)
                            }
                        }
                )
            }
            .edgesIgnoringSafeArea(.all) // Gør at grid'et går helt ud til kanten
                
            // Knap til at færdiggøre testen
            DefaultButton(title:"Finish Test") {
                if viewModel.isTestCompleted() {
                    onComplete()
                } else {
                    alertMessage = "Test Failed: Please complete all fields."
                }
                showAlert = true
            }
            //.padding()
            //.background(Color.blue)
            //.foregroundColor(.white)
            //.cornerRadius(10)
            .alert(isPresented: $showAlert) {
                Alert(title: Text(alertMessage))
            }
                
            // Knap til at nulstille testen
        SecondaryButton(title:"Reset Test") {
                viewModel.resetGrid()
            }
            .padding()
        }
    }


#Preview {
    TouchTest()
}
