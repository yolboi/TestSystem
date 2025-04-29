//
//  AudioTestView.swift
//  TestSystem
//
//  Created by Jarl Boyd Roest on 29/04/2025.
//
import SwiftUI

struct EarpieceView: View {
    private let atm = EarpieceTest()
    @State private var testMode = 0
    @State private var statusText = "Tryk for at starte højtalertest"

    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "ear.badge.waveform")
                .resizable()
                .frame(width: 80, height: 100)
                .padding(.top, 30)

            Spacer()
            
            Text(statusText)
                .font(.headline)
                .padding()

            DefaultButton(title: "Start Audiotest") {
                if testMode % 2 == 0 {
                    statusText = "Testing speaker"
                    atm.earSpeakerTest(text: "Testing speaker", earSpeaker: false)
                } else {
                    statusText = "Testing Earpiece"
                    atm.earSpeakerTest(text: "Testing Earpiece", earSpeaker: true)
                }
                testMode += 1
            }

            SecondaryButton(title: "End test") {
                atm.stopSpeaking()
                statusText = "Test stoppet"
            }
        }
        .padding()
    }
}
#Preview {
    EarpieceView()
}
