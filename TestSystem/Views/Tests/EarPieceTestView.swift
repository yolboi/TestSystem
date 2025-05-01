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
    @State private var statusImage = "iphone.gen3.badge.play"

    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: statusImage)
                .resizable()
                .scaledToFit()
                .frame(width: 80, height: 100)
                .padding(.top, 30)

            Spacer()
            
            Text("Test info her")
                .font(.headline)
            
            Spacer()
            
            Text(statusText)
                .font(.headline)
                .padding()

            DefaultButton(title: "Start Audiotest") {
                if testMode % 2 == 0 {
                    statusText = "Testing speaker"
                    statusImage = "speaker.3.fill"
                    atm.earSpeakerTest(text: "Testing speaker", image: "speaker.3.fill", earSpeaker: false)
                } else {
                    statusText = "Testing Earpiece"
                    statusImage = "ear.badge.waveform"
                    atm.earSpeakerTest(text: "Testing Earpiece", image: "ear.badge.waveform", earSpeaker: true)
                }
                testMode += 1
            }

            SecondaryButton(title: "End test") {
                atm.stopSpeaking()
                statusText = "Test stoppet"
                statusImage = "memories"
            }
        }
        .padding()
    }
}
#Preview {
    EarpieceView()
}
