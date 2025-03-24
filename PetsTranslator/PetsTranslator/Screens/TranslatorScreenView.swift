//
//  TranslatorScreenView.swift
//  PetsTranslator
//
//  Created by Stas Boiko on 3/21/25.
//

import SwiftUI
import SDWebImageSwiftUI

enum TranslatorScreenState {
    case translator
    case processOfTranslation
    case result
}

enum CharacterType: String {
    case human = "HUMAN"
    case pet = "PET"
}

struct TranslatorScreenView: View {
    
    @EnvironmentObject private var viewModel: TranslatorViewModel
    
    var body: some View {
        VStack {
            buildViewAcordingToState(viewModel.screenState)
            petSection
        }
        .foregroundStyle(.appTint)
        .padding(.vertical, 12)
        .padding(.bottom, 120)
        .animation(.easeInOut, value: viewModel.selectedPet)
        .animation(.smooth(duration: 0.1), value: viewModel.translateFrom)
        .alert("Enable Microphone Access", isPresented: $viewModel.isMicrophoneAccessDenied) {
            Button("Cancel") {}
            
            Button("Settings", role: .cancel) {
                guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else { return }
                
                if UIApplication.shared.canOpenURL(settingsUrl) {
                    UIApplication.shared.open(settingsUrl)
                }
            }
        } message: {
            Text("Please allow access to your mircophone to use the app’s features")
        }
    }
    
    @ViewBuilder
    private func buildViewAcordingToState(_ state: TranslatorScreenState) -> some View {
        switch state {
        case .translator:
            translatorView
        case .processOfTranslation:
            VStack {
                Spacer()
                Text("Process of translation...")
                    .font(.customMedium)
                    .padding(.bottom, 60)
            }
        case .result:
            resultView
        }
    }
    
    private var translatorView: some View {
        VStack {
            translatorTitle
            swapCharactersSection
            speakSection
        }
    }
    
    private var resultView: some View {
        VStack {
            resultTitle
            
            resultTextSection
            
            Spacer()
        }
    }
    
    private var resultTitle: some View {
        Button {
            viewModel.screenState = .translator
        } label: {
            ZStack {
                Text("Result")
                    .font(.customTitle)
                
                HStack {
                    ZStack {
                        RoundedRectangle(cornerRadius: .infinity)
                            .fill(.white)
                            .frame(width: 48, height: 48)
                        Image(.closeButtonIcon)
                            .resizable()
                            .frame(width: 28, height: 28)
                        
                    }
                    Spacer()
                }
            }
            .frame(height: 58)
            .padding(.horizontal, 20)
            .padding(.bottom, 90)
        }
    }
    
    private var resultTextSection: some View {
        ZStack(alignment: .center) {
            BubbleMassageShape()
                .fill(.purpleTileBackground)
                .frame(height: 250)
                .shadow(color: .black.opacity(0.15), radius: 5, y: 4)
            
            ZStack {
                RoundedRectangle(cornerRadius: 16)
                    .fill(.clear)
                    .frame(height: 150)
                    
                Text("What are you doing, human?")
                    .font(.customSmall)
                    .padding(20)
            }
            .offset(y: -50)
        }
        .padding(.horizontal, 50)
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
    }
    
    private var speakSection: some View {
        HStack(spacing: 35) {
            Button {
                viewModel.requestMicrophoneAccess()
                if !viewModel.isMicrophoneAccessDenied {
                    viewModel.startListening()
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
                        
                        Text(viewModel.isRecording ? "Recording..." : "Start Speak")
                            .font(.customMedium)
                    }
                    .clipped()
                    .padding(.bottom, 12)
                    .padding(.horizontal, 20)
                }
            }
            
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
            
        }
        .frame(height: 176)
        .padding(.horizontal, 35)
        .padding(.top, 50)
        .padding(.bottom, 50)
    }
    
    private var petSection: some View {
        viewModel.selectedPet.icon
            .resizable()
            .frame(width: 184, height: 184)
            .onTapGesture {
                switch viewModel.screenState {
                case .translator:
                    viewModel.screenState = .processOfTranslation
                case .processOfTranslation:
                    viewModel.screenState = .result
                case .result:
                    viewModel.screenState = .translator
                }
            }
    }
}

#Preview {
    TranslatorScreenView()
        .environmentObject(TranslatorViewModel())
}
