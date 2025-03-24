//
//  TranslatorViewModel.swift
//  PetsTranslator
//
//  Created by Stas Boiko on 3/23/25.
//

import Foundation
import AVFoundation
import SoundAnalysis

class SoundClassifier: NSObject, SNResultsObserving, ObservableObject {
    
    private let audioEngine = AVAudioEngine()
    private var streamAnalyzer: SNAudioStreamAnalyzer?
    
    override init() {
        super.init()
        setupAudioEngine()
    }
    
    func startRecording() {
        do {
            try audioEngine.start()
        } catch {
            print("Error starting audio engine: \(error)")
        }
    }
    
    func stopRecording() {
        audioEngine.stop()
    }

   private  func setupAudioEngine() {
        let inputNode = audioEngine.inputNode
        let format = inputNode.outputFormat(forBus: 0)
        streamAnalyzer = SNAudioStreamAnalyzer(format: format)
        
        do {
            let model = try AnimalSoundClassifier(configuration: .init())
            let request = try SNClassifySoundRequest(mlModel: model.model)
            try streamAnalyzer?.add(request, withObserver: self)
            
            let recordingFormat = inputNode.outputFormat(forBus: 0)
            inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { (buffer, when) in
                if self.isSilent(buffer) {
                    return
                }
                self.streamAnalyzer?.analyze(buffer, atAudioFramePosition: when.sampleTime)
            }
            
            audioEngine.prepare()
        } catch {
            print("Failed sound classifier model setup: \(error)")
        }
    }
    
    func request(_ request: SNRequest, didProduce result: SNResult) {
        
        guard let classificationResult = result as? SNClassificationResult else {
            print("No classification result")
            return
        }
        
        if let bestClassification = classificationResult.classifications.first {
            
            if bestClassification.confidence >= 0.999 {
                print("Detected sound: \(bestClassification.identifier) with confidence \(bestClassification.confidence)")
                
                //send detected result
            }
        }  else {
            print("No confident classification found")
        }
    }
    
    private func isSilent(_ buffer: AVAudioPCMBuffer) -> Bool {
        let channelData = buffer.floatChannelData?[0]
        let frameLength = Int(buffer.frameLength)
        
        guard frameLength > 0 else { return true }
        
        let sum = (0..<frameLength).reduce(0.0) { $0 + fabsf(channelData![$1]) }
        let avgAmplitude = sum / Float(frameLength)
        
        return avgAmplitude < 0.01 // Silence threshold
    }
}


class TranslatorViewModel: ObservableObject {
    @Published var selectedPet: Pet = .cat
    @Published var translateFrom: CharacterType = .human
    
    @Published var isRecording = false
    
    @Published var isMicrophoneAccessDenied = false
    
    let soundClassifier = SoundClassifier()
    
    func startListening() {
        isRecording = true
        soundClassifier.startRecording()
    }
    
    func requestMicrophoneAccess() {
        AVAudioApplication.requestRecordPermission { granted in
            self.isMicrophoneAccessDenied = !granted
        }
    }
}
