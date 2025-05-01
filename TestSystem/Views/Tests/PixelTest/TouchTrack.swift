//
//  TouchTrack.swift
//  TestSystem
//
//  Created by Jarl Boyd Roest on 30/04/2025.
//

import SwiftUI

struct TouchTrackingView: UIViewRepresentable {
    var onSingleTouch: (CGPoint) -> Void
    var onTwoFingerTap: () -> Void

    func makeUIView(context: Context) -> TouchView {
        let view = TouchView()
        view.onSingleTouch = onSingleTouch
        view.onTwoFingerTap = onTwoFingerTap
        return view
    }

    func updateUIView(_ uiView: TouchView, context: Context) {}

    class TouchView: UIView {
        var onSingleTouch: ((CGPoint) -> Void)?
        var onTwoFingerTap: (() -> Void)?

        override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
            guard let touch = touches.first else { return }

            if event?.allTouches?.count == 2 {
                onTwoFingerTap?()
            } else if event?.allTouches?.count == 1 {
                let point = touch.location(in: self)
                onSingleTouch?(point)
            }
        }
    }
}
