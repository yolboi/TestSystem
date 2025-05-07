//
//  EarpieceService.swift
//  TestSystem
//
//  Created by Jarl Boyd Roest on 07/05/2025.
//

import Foundation
import AVFoundation

class EarpieceAudioService {
    private let synthesizer = AVSpeechSynthesizer()
    private let audioSession = AVAudioSession.sharedInstance()

    func play(text: String, earSpeaker: Bool) {
        do {
            if earSpeaker {
                try audioSession.setCategory(.playAndRecord, options: .duckOthers)
            } else {
                try audioSession.setCategory(.playAndRecord, options: .defaultToSpeaker)
            }
            try audioSession.setActive(true)
        } catch {
            print("Audio session setup failed: \(error)")
        }

        let utterance = AVSpeechUtterance(string: text)
        utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
        utterance.rate = AVSpeechUtteranceDefaultSpeechRate
        synthesizer.speak(utterance)
    }

    func stop() {
        synthesizer.stopSpeaking(at: .immediate)
        try? audioSession.setActive(false)
    }
}
