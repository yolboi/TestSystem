//
//  TouchTrack.swift
//  TestSystem
//
//  Created by Jarl Boyd Roest on 30/04/2025.
//
// A custom UIViewRepresentable that detects single touches and two-finger taps
//

import SwiftUI

struct TouchTrackingView: UIViewRepresentable {
    var onSingleTouch: (CGPoint) -> Void  /// Called when a single finger tap occurs
    var onTwoFingerTap: () -> Void /// Called when a two-finger tap occurs

    func makeUIView(context: Context) -> TouchView {
        let view = TouchView()
        view.onSingleTouch = onSingleTouch
        view.onTwoFingerTap = onTwoFingerTap
        return view
    }

    func updateUIView(_ uiView: TouchView, context: Context) {}

    /// Custom UIView that handles touch events
    class TouchView: UIView {
        var onSingleTouch: ((CGPoint) -> Void)? /// Callback for single touch
        var onTwoFingerTap: (() -> Void)? /// Callback for two-finger tap

        override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
            guard let touch = touches.first else { return }

            if event?.allTouches?.count == 2 {
                /// Two fingers detected
                onTwoFingerTap?()
            } else if event?.allTouches?.count == 1 {
                /// Single finger detected, capture location
                let point = touch.location(in: self)
                onSingleTouch?(point)
            }
        }
    }
}
