//
//  AudioTest.swift
//  TestSystem
//
//  Created by Jarl Boyd Roest on 29/04/2025.
//
// Manages the earpiece and speaker audio test flow,
// including controlling audio playback, updating UI state, and saving results.
//
import Foundation
import AVFoundation
import Combine

class EarpieceTestVM: ObservableObject {
    @Published var statusText: String = "Press to start the audio test"
    @Published var statusImage: String = "iphone.gen3.badge.play"
    @Published var testCompleted: Bool = false

    private let audioService = EarpieceAudioService() ///text-to-speech playback either through the speaker or the earpiece
    private var testMode: Int = 0 ///Internal counter that tracks whether the app is testing the speaker or the earpiece

    func startTest() {
        if testMode % 2 == 0 { ///if testMode is even: Tests the speaker else earpeice
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

    ///Stops any ongoing audio playback
    func stopTest() {
        audioService.stop()
        statusText = "Test stopped"
        statusImage = "memories"
    }

    ///Marks it as passed if testCompleted is true, otherwise adds a note: "Test not completed", saves in TestOverviewViewModel
    func finishTest(using testOverviewVM: TestOverviewViewModel) {
        let result = TestResult(
            testType: .ear,
            passed: testCompleted,
            timestamp: Date(),
            notes: testCompleted ? nil : "Test not completed",
            confirmed: true
        )
        testOverviewVM.addResult(result)
    }
    
    func runTestCycle(mode: Int) {
        startTest()
    }
}
