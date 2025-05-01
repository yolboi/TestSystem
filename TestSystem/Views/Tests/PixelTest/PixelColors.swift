//
//  PixelColors.swift
//  TestSystem
//
//  Created by Jarl Boyd Roest on 30/04/2025.
//

import SwiftUI

struct PixelTestScreen: View {
    @ObservedObject var viewModel: PixelTestViewModel

    var body: some View {
        ZStack {
            viewModel.currentColor
                .ignoresSafeArea()
                .animation(.easeInOut, value: viewModel.currentColor) // Blød overgang

            // Markér fejl
            ForEach(viewModel.markedErrors, id: \.self) { point in
                Rectangle()
                    .stroke(Color.black, lineWidth: 2)
                    .frame(width: 30, height: 30)
                    .position(point)
            }

            // Touch handler – 1 finger: markér fejl, 2 fingre: skift farve (valgfrit)
            TouchTrackingView(
                onSingleTouch: { point in
                    viewModel.addError(at: point)
                },
                onTwoFingerTap: {
                    withAnimation {
                        viewModel.nextColor()
                    }
                }
            )
            .background(Color.clear)
        }
        .gesture(
            DragGesture(minimumDistance: 30)
                .onEnded { value in
                    if abs(value.translation.width) > abs(value.translation.height) {
                        withAnimation {
                            if value.translation.width < 0 {
                                viewModel.nextColor()
                            } else {
                                viewModel.previousColor()
                            }
                        }
                    }
                }
        )
    }
}
