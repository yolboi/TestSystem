//
//  EarpieceService.swift
//  TestSystem
//
//  Created by Jarl Boyd Roest on 07/05/2025.
//
//  Provides text-to-speech playback either through the earpiece
//  or the loudspeaker. Manages AVAudioSession routing and speech
//  generation using AVSpeechSynthesizer.
//

import Foundation
import AVFoundation

class EarpieceAudioService {
    private let synthesizer = AVSpeechSynthesizer() ///generating speech from a text string
    private let audioSession = AVAudioSession.sharedInstance() ///audio settings for playback, speaker/earpiece selection.

    ///Plays the given text as speech.
    func play(text: String, earSpeaker: Bool) {
        do {
            if earSpeaker {
                try audioSession.setCategory(.playAndRecord, options: .duckOthers) /// Audio is played through the earpiece speaker
            } else { ///Audio is played through the loudspeaker
                try audioSession.setCategory(.playAndRecord, options: .defaultToSpeaker) ///Audio is played through the loudspeaker
            }
            try audioSession.setActive(true)
        } catch {
            print("Audio session setup failed: \(error)")
        }

        /// Controls the speaking rate, language, and use synthesizer to speak
        let utterance = AVSpeechUtterance(string: text)
        utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
        utterance.rate = AVSpeechUtteranceDefaultSpeechRate
        synthesizer.speak(utterance)
    }

    /// stops any ongoing speech and deactivates the audio session
    func stop() {
        synthesizer.stopSpeaking(at: .immediate)
        try? audioSession.setActive(false)
    }
}
