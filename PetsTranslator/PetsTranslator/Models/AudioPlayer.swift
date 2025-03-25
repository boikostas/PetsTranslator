//
//  AudioPlayer.swift
//  PetsTranslator
//
//  Created by Stas Boiko on 3/25/25.
//

import AVFoundation

class AudioPlayer {
    var player: AVAudioPlayer?

    func playSound(named filename: String) {
        if let url = Bundle.main.url(forResource: filename, withExtension: "wav") {
            do {
                player = try AVAudioPlayer(contentsOf: url)
                player?.play()
            } catch {
                print("Error playing sound: \(error.localizedDescription)")
            }
        } else {
            print("Audio file not found.")
        }
    }

    func stopSound() {
        player?.stop()
    }
}
