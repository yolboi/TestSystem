//
//  Shake.swift
//  TestSystem
//
//  Created by Jarl Boyd Roest on 23/04/2025.
//

import SwiftUI

struct ShakeTestView: View {
    @StateObject private var detector = ShakeDetector()
    @State private var statusText = "Ryst telefonen for at teste"

    var body: some View {
        VStack(spacing: 20) {
            Text(statusText)
                .font(.title2)
            Image(systemName: detector.shakeDetected ? "hand.raised.fill" : "hand.raised")
                .font(.system(size: 60))
                .foregroundColor(detector.shakeDetected ? .green : .gray)
        }
        .padding()
        .onReceive(detector.$shakeDetected) { didShake in
            if didShake {
                statusText = "Shake registreret! "
                // evt. navigere videre:
                // navModel.navigate(to: .threeD)
            }
        }
    }
}
