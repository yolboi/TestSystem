//
//  TouchTest.swift
//  TestSystem
//
//  Created by Jarl Boyd Roest on 04/03/2025.
//

import SwiftUI

struct TouchTest: View {
    @StateObject private var viewModel = TouchTestM()
    @State private var alertMessage: String = ""
    @State private var showAlert: Bool = false
        
    var body: some View {
        VStack(spacing: 2) {
            // Grid'et med rektangler, der skifter farve når de berøres
            ForEach(0..<viewModel.rows, id: \.self) { i in
                HStack(spacing: 2) {
                    ForEach(0..<viewModel.columns, id: \.self) { j in
                        Rectangle()
                            .fill(viewModel.touched[i][j] ? Color.green : Color.gray)
                            .frame(width: 60, height: 60)
                            .onTapGesture {
                                viewModel.markTouched(row: i, col: j)
                            }
                        }
                    }
                }
                .padding()
                
            // Knap til at færdiggøre testen
            DefaultButton(title:"Finish Test") {
                if viewModel.isTestCompleted() {
                    alertMessage = "Test Passed!"
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
}

#Preview {
    TouchTest()
}
