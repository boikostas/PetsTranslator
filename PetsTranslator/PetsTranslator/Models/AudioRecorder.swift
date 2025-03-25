//
//  AudioRecorder.swift
//  PetsTranslator
//
//  Created by Stas Boiko on 3/25/25.
//

import AVFoundation

class AudioRecorder: NSObject {
    var audioRecorder: AVAudioRecorder?
    var url: URL?
    
    var recordedUrl: ((URL) -> Void)?

    func startRecording() {
        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setCategory(.playAndRecord, mode: .default, options: .defaultToSpeaker)
            try audioSession.setActive(true)

            url = FileManager.default.temporaryDirectory.appendingPathComponent("recording.m4a")
            let settings: [String: Any] = [
                AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
                AVSampleRateKey: 12000,
                AVNumberOfChannelsKey: 1,
                AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
            ]
            if let url {
                audioRecorder = try AVAudioRecorder(url: url, settings: settings)
            } else {
                print("Invalid URL: \(String(describing: url))")
            }
            audioRecorder?.record()
        } catch {
            print("Failed to start recording: \(error)")
        }
    }

    func stopRecording() {
        audioRecorder?.stop()
        if let url {
            recordedUrl?(url)
            print("Successfully saved recorded file to: \(url)")
        }
    }
}
