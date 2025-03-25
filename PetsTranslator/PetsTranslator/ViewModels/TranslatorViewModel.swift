//
//  TranslatorViewModel.swift
//  PetsTranslator
//
//  Created by Stas Boiko on 3/23/25.
//

import Foundation
import AVFAudio

class TranslatorViewModel: ObservableObject {
    @Published var selectedPet: Pet = .cat
    @Published var translateFrom: CharacterType = .human
    
    @Published var screenState: TranslatorScreenState = .translator
    
    @Published var isRecording = false
    
    @Published var isMicrophoneAccessDenied = false
    
    @Published var translatedText = ""
    
    @Published var transcriptioError: TranscriptionError?
    
    let soundClassifier = SoundClassifier()
    let audioRecorder = AudioRecorder()
    
    init() {
        listenForPetDetection()
        listenForRecordedUrl()
    }
    
    func startRecordingHumanSpeech() {
        isRecording = true
        transcriptioError = nil
        audioRecorder.startRecording()
    }
    
    func stopRecordingHumanSpeech() {
        isRecording = false
        audioRecorder.stopRecording()
    }
    
    private func listenForRecordedUrl() {
        audioRecorder.recordedUrl = { [weak self] url in
            guard let self else { return }
            SpeechToText.transcribeAudio(url: url) { result in
                switch result {
                case .success(let transcriptedString):
                    self.translatedText = transcriptedString
                    
                    DispatchQueue.main.async {
                        self.screenState = .processOfTranslation
                    }
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        self.screenState = .result
                    }

                case .failure(let noSpeechDetected):
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        self.transcriptioError = noSpeechDetected
                    }
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                        self.transcriptioError = nil
                    }
                }
            }
        }
    }
    
    func startListeningForPetSound() {
        isRecording = true
        soundClassifier.startRecording()
    }
    
    func stopListeningForPetSounds() {
        DispatchQueue.main.async {
            self.isRecording = false
        }
        soundClassifier.stopRecording()
    }
    
    private func listenForPetDetection() {
        soundClassifier.detectedPet = { [weak self] pet in
            guard let self else { return }
            translateAnimalSound(pet)
        }
    }
    
    private func translateAnimalSound(_ pet: Pet) {
        DispatchQueue.main.async {
            self.selectedPet = pet
            self.screenState = .processOfTranslation
            if let translation = pet.translationsOfSounds.randomElement() {
                self.translatedText = translation
            }
        }
        
        self.stopListeningForPetSounds()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.screenState = .result
        }
    }
    
    func requestMicrophoneAccess() {
        AVAudioApplication.requestRecordPermission { granted in
            self.isMicrophoneAccessDenied = !granted
        }
    }
}
