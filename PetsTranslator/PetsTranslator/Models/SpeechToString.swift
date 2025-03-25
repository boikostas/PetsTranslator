//
//  SpeechToString.swift
//  PetsTranslator
//
//  Created by Stas Boiko on 3/25/25.
//

import Speech

enum TranscriptionError: String, Error {
    case noSpeechDetected = "No speech detected"
}

class SpeechToText {

    static func transcribeAudio(url: URL, completion: @escaping (Result<String, TranscriptionError>) -> Void) {
        let recognizer = SFSpeechRecognizer()
        let request = SFSpeechURLRecognitionRequest(url: url)

        recognizer?.recognitionTask(with: request) { result, error in
            if let result = result {
                let transcriptedString = result.bestTranscription.formattedString
                completion(.success(transcriptedString))
            } else if let error = error {
                completion(.failure(.noSpeechDetected))
                print("Transcription error: \(error)")
            }
        }
    }
}
