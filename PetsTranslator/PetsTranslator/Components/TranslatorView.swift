//
//  TranslatorView.swift
//  PetsTranslator
//
//  Created by Stas Boiko on 3/25/25.
//

import SwiftUI
import SDWebImageSwiftUI

struct TranslatorView: View {
    
    @EnvironmentObject var viewModel: TranslatorViewModel
    
    var body: some View {
        translatorView
    }
    
    private var translatorView: some View {
        VStack {
            translatorTitle
            swapCharactersSection
            speakSection
        }
    }
    
    private var translatorTitle: some View {
        Text(Tab.translator.title)
            .font(.customTitle)
            .frame(height: 58)
    }
    
    private var swapCharactersSection: some View {
        HStack(spacing: 8) {
            Text(viewModel.translateFrom == .human ? CharacterType.human.rawValue : CharacterType.pet.rawValue)
                .frame(width: 135, height: 61)
            
            //MARK: Swap button
            Button {
                switch viewModel.translateFrom {
                case .human:
                    viewModel.translateFrom = .pet
                case .pet:
                    viewModel.translateFrom = .human
                }
            } label: {
                Image(.arrowSwapIcon)
                    .resizable()
                    .frame(width: 24, height: 24)
            }
            
            Text(viewModel.translateFrom == .human ? CharacterType.pet.rawValue : CharacterType.human.rawValue)
                .frame(width: 135, height: 61)
        }
        .font(.customMedium)
        .padding(.top, 12)
        .disabled(viewModel.isRecording)
    }
    
    private var speakSection: some View {
        HStack(spacing: 35) {
            //MARK: Speak button
            Button {
                viewModel.requestMicrophoneAccess()
                if !viewModel.isMicrophoneAccessDenied {
                    if viewModel.translateFrom == .pet {
                        if viewModel.isRecording {
                            viewModel.stopListeningForPetSounds()
                        } else {
                            viewModel.startListeningForPetSound()
                        }
                    } else if viewModel.translateFrom == .human {
                        if viewModel.isRecording {
                            viewModel.stopRecordingHumanSpeech()
                        } else {
                            viewModel.startRecordingHumanSpeech()
                        }
                    }
                }
            } label: {
                ZStack(alignment: .bottom) {
                    RoundedRectangle(cornerRadius: 16)
                        .fill(.white)
                        .shadow(color: .black.opacity(0.25), radius: 5, y: 4)
                        .frame(width: 178)
                    
                    VStack(spacing: 24) {
                        if viewModel.isRecording {
                            AnimatedImage(name: "recordingGIF.gif")
                                .resizable()
                                .frame(height: 100)
                                .scaleEffect(2)
                            
                        } else {
                            Image(.microphoneIcon)
                                .resizable()
                                .frame(width: 70, height: 70)
                        }
                        
                        VStack {
                            Text(viewModel.isRecording  ? (viewModel.translateFrom == .human ? "Recording..." : "Listening...") : (viewModel.translateFrom == .human ? "Start Speak" : "Start Listen"))
                                .font(.customMedium)
                            
                            if viewModel.translateFrom == .human && viewModel.isRecording {
                                Text("Tap to Stop Recording")
                                    .font(.customSmall)
                            } else if viewModel.translateFrom == .pet && viewModel.isRecording {
                                Text("Tap to Stop Listening")
                                    .font(.customSmall)
                            }
                            
                            if let error = viewModel.transcriptioError {
                                Text(error.rawValue)
                                    .font(.customSmall)
                                    .foregroundStyle(.red)
                                
                            }
                        }
                    }
                    .clipped()
                    .padding(.bottom, 12)
                    .padding(.horizontal, 20)
                }
            }
            
            //MARK: Choose pet button
            ZStack {
                RoundedRectangle(cornerRadius: 16)
                    .fill(.white)
                    .shadow(color: .black.opacity(0.25), radius: 5, y: 4)
                
                VStack(spacing: 12){
                    Button {
                        viewModel.selectedPet = .cat
                    } label: {
                        PetTileView(pet: .cat)
                            .opacity(viewModel.selectedPet == .cat ? 1 : 0.5)
                    }
                    
                    Button {
                        viewModel.selectedPet = .dog
                    } label: {
                        PetTileView(pet: .dog)
                            .opacity(viewModel.selectedPet == .dog ? 1 : 0.5)
                    }
                }
                .padding(.vertical, 12)
                .padding(.horizontal, 18.5)
            }
            .frame(width: 107)
            .disabled(viewModel.isRecording)
            
        }
        .frame(height: 176)
        .padding(.horizontal, 35)
        .padding(.top, 50)
        .padding(.bottom, 50)
    }
}
