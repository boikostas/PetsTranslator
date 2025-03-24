//
//  TranslatorScreenView.swift
//  PetsTranslator
//
//  Created by Stas Boiko on 3/21/25.
//

import SwiftUI
import SDWebImageSwiftUI

enum CharacterType: String {
    case human = "HUMAN"
    case pet = "PET"
}

struct TranslatorScreenView: View {
    
    @EnvironmentObject private var viewModel: TranslatorViewModel
    
    var body: some View {
        VStack {
            title
            swapCharactersSection
            speakSection
            petSection

            Spacer()
        }
        .foregroundStyle(.appTint)
        .padding(.vertical, 12)
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
    
    private var title: some View {
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
    }
}

#Preview {
    TranslatorScreenView()
        .environmentObject(TranslatorViewModel())
}
