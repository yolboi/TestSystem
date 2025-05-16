//
//  TouchTest.swift
//  TestSystem
//
//  Created by Jarl Boyd Roest on 04/03/2025.
//
// View for testing the touch screen by having users touch all grid squares
//

import SwiftUI

struct TouchTest: View {
    @EnvironmentObject var testOverviewVM: TestOverviewViewModel
    @EnvironmentObject var navModel: NavigationModel

    var fullScreenVM: FullScreenTestViewModel? = nil

    @StateObject private var viewModel = TouchTestViewModel()
    @State private var showFailAlert: Bool = false

    var body: some View {
        VStack {
            GeometryReader { geometry in
                let squareWidth = geometry.size.width / CGFloat(viewModel.columns)
                let squareHeight = geometry.size.height / CGFloat(viewModel.rows)

                VStack(spacing: 0) {
                    ForEach(0..<viewModel.rows, id: \.self) { row in
                        HStack(spacing: 0) {
                            ForEach(0..<viewModel.columns, id: \.self) { col in
                                ZStack {
                                    Rectangle()
                                        .stroke(Color.gray, lineWidth: 1)
                                        .frame(width: squareWidth, height: squareHeight)

                                    if viewModel.touched[row][col] {
                                        Theme.bubblegum.mainColor
                                    }
                                }
                            }
                        }
                    }
                }
                .gesture(
                    DragGesture(minimumDistance: 0)
                        .onChanged { value in
                            let col = Int(value.location.x / squareWidth)
                            let row = Int(value.location.y / squareHeight)
                            if row >= 0 && row < viewModel.rows && col >= 0 && col < viewModel.columns {
                                viewModel.markTouched(row: row, col: col)
                            }
                        }
                )
            }

            /// Finish Test button
            DefaultButton(title: "Finish Test") {
                if viewModel.isTestCompleted() {
                    viewModel.saveResult(to: testOverviewVM)
                    fullScreenVM?.goToNextStep() ?? navModel.path.removeLast()
                } else {
                    showFailAlert = true
                }
            }

            /// Reset Test button
            SecondaryButton(title: "Reset Test") {
                viewModel.resetGrid()
            }

            Spacer()
        }
        .padding()
        .alert(isPresented: $showFailAlert) {
            Alert(
                title: Text("Test Failed"),
                message: Text("Not all squares were touched."),
                primaryButton: .destructive(Text("Fail Test")) {
                    // Force-fail og gem
                    viewModel.saveResult(to: testOverviewVM)
                    fullScreenVM?.goToNextStep() ?? navModel.path.removeLast()
                },
                secondaryButton: .cancel(Text("Continue Test"))
            )
        }
    }
}

#Preview {
    TouchTest()
        .environmentObject(FullScreenTestViewModel())
        .environmentObject(NavigationModel())
        .environmentObject(TestOverviewViewModel())
}
