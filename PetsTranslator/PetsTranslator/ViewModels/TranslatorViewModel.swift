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
    
    @Published var soundToPlayName: String?
    
    private let soundClassifier = SoundClassifier()
    private let audioRecorder = AudioRecorder()
    private let audioPlayer = AudioPlayer()
    
    init() {
        listenForPetDetection()
        listenForRecordedUrl()
    }
    
    func stopAudioPlayer() {
        audioPlayer.stopSound()
    }
    
    func playSound(_ named: String) {
        audioPlayer.playSound(named: named)
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
                        
                        if let emotion = self.getEmotionFromText(transcriptedString) {
                            self.soundToPlayName = self.decideWhatSoundToPlayFromEmotion(emotion)
                            
                            if let soundName =  self.soundToPlayName {
                                self.audioPlayer.playSound(named: soundName)
                            }
                        }
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
    
    private func decideWhatSoundToPlayFromEmotion(_ emotion: Pet.Emotion) -> String? {
        switch selectedPet {
        case .dog:
            switch emotion {
            case .happy:
                return ["dogHappy1", "dogHappy2"].randomElement()
            case .sad:
                return ["dogSad1", "dogSad2"].randomElement()
            case .angry:
                return ["dogAngry1", "dogAngry2"].randomElement()
            case .hungry:
                return ["dogHungry1", "dogHungry2"].randomElement()
            case .defaultEmotion:
                return ["dogDefault1", "dogDefault2"].randomElement()
            }
        case .cat:
            switch emotion {
            case .happy:
                return ["catHappy1", "catHappy2"].randomElement()
            case .sad:
                return ["catSad1", "catSad2"].randomElement()
            case .angry:
                return ["catAngry1", "catAngry2"].randomElement()
            case .hungry:
                return ["catHungry1", "catHungry2"].randomElement()
            case .defaultEmotion:
                return ["catDefault1", "catDefault2"].randomElement()
            }
        }
    }
    
    private func getEmotionFromText(_ text: String) -> Pet.Emotion? {
        if Pet.Emotion.happy.relevantWords.contains(where: { text.lowercased().contains($0) }) {
            return .happy
        } else if Pet.Emotion.sad.relevantWords.contains(where: { text.lowercased().contains($0) }) {
            return .sad
        } else if Pet.Emotion.hungry.relevantWords.contains(where: { text.lowercased().contains($0) }) {
            return .hungry
        } else if Pet.Emotion.angry.relevantWords.contains(where: { text.lowercased().contains($0) }) {
            return .angry
        } else {
            return .defaultEmotion
        }
    }
}
