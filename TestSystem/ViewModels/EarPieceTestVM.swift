//
//  AudioTest.swift
//  TestSystem
//
//  Created by Jarl Boyd Roest on 29/04/2025.
//

import Foundation
import AVFoundation
import Combine

class EarpieceTestVM: ObservableObject {
    @Published var statusText: String = "Press to start the audio test"
    @Published var statusImage: String = "iphone.gen3.badge.play"
    @Published var testCompleted: Bool = false

    private let audioService = EarpieceAudioService()
    private var testMode: Int = 0

    func startTest() {
        if testMode % 2 == 0 {
            statusText = "Testing speaker"
            statusImage = "speaker.3.fill"
            audioService.play(text: "Testing speaker", earSpeaker: false)
        } else {
            statusText = "Testing earpiece"
            statusImage = "ear.badge.waveform"
            audioService.play(text: "Testing earpiece", earSpeaker: true)
            testCompleted = true
        }
        testMode += 1
    }

    func stopTest() {
        audioService.stop()
        statusText = "Test stopped"
        statusImage = "memories"
    }

    func finishTest(using testOverviewVM: TestOverviewViewModel) {
        let result = TestResult(
            testType: .ear,
            passed: testCompleted,
            timestamp: Date(),
            notes: testCompleted ? nil : "Test not completed",
            confirmed: true
        )

        // Antager at TestOverviewViewModel har en metode der håndterer opdatering/tilføjelse
        testOverviewVM.addResult(result)
    }
    
    func runTestCycle(mode: Int) {
        startTest()
    }
}
