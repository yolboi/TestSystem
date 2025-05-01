//
//  AudioTest.swift
//  TestSystem
//
//  Created by Jarl Boyd Roest on 29/04/2025.
//

import AVFoundation
import Foundation

class EarpieceTest {
    static let shared = EarpieceTest()
    private let synthesizer = AVSpeechSynthesizer()
    private var audioPlayer = AVAudioSession.sharedInstance()
    
    func earSpeakerTest (text: String, image: String,earSpeaker: Bool) {
        do {
            if earSpeaker {
                try audioPlayer.setCategory(.playAndRecord, options: .duckOthers)
            } else {
                try audioPlayer.setCategory(.playAndRecord, options: .defaultToSpeaker)
            }
            try audioPlayer.setActive(true)
        } catch {
            print("error")
        }
        let utterance = AVSpeechUtterance(string: "hello")
        utterance.rate = AVSpeechUtteranceDefaultSpeechRate
        utterance.voice = AVSpeechSynthesisVoice(language: "id-ID")
        
        synthesizer.speak(utterance)
    }
    
    func stopSpeaking() {
        synthesizer.stopSpeaking(at: .immediate)
        
        do {
            try audioPlayer.setActive(false)
        } catch {
            print("error")
        }
    }
}
