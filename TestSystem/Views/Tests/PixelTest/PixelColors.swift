//
//  PixelColors.swift
//  TestSystem
//
//  Created by Jarl Boyd Roest on 30/04/2025.
//
//  Displays a solid color screen for pixel inspection, allows marking dead pixels by tapping,
//  and switching colors via double finger tab.
//

import SwiftUI

struct PixelTestScreen: View {
    @ObservedObject var viewModel: PixelTestViewModel /// ViewModel managing the pixel test state

    var body: some View {
        ZStack {
            /// Current test color background (red, green, or blue)
            viewModel.currentColor
                .ignoresSafeArea()
                .animation(.easeInOut, value: viewModel.currentColor) /// Smooth color transitions

            /// Draw rectangles where pixel errors were marked
            ForEach(viewModel.markedErrors, id: \.self) { point in
                Rectangle()
                    .stroke(Color.black, lineWidth: 2)
                    .frame(width: 30, height: 30)
                    .position(point)
            }

            /// Touch Tracking Overlay, single finger tap: Mark a pixel error, two-finger tap: Switch to the next color
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
        // Swipe Gesture Handler, swipe left: next color, swipe right: previous color
        .gesture(
            DragGesture(minimumDistance: 30)
                .onEnded { value in
                    if abs(value.translation.width) > abs(value.translation.height) {
                        withAnimation {
                            if value.translation.width < 0 {
                                viewModel.nextColor() ///Swipe left -> next color
                            } else {
                                viewModel.previousColor() /// Swipe right -> previous color
                            }
                        }
                    }
                }
        )
    }
}
