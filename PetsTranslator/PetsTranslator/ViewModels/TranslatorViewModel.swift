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
    
    let soundClassifier = SoundClassifier()
    
    init() {
        listenForPetDetection()
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
