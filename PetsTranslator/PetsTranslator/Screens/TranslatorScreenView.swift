//
//  TranslatorScreenView.swift
//  PetsTranslator
//
//  Created by Stas Boiko on 3/21/25.
//

import SwiftUI

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
        .animation(.easeInOut, value: viewModel.screenState)
        .animation(.easeInOut, value: viewModel.isRecording)
        .animation(.easeInOut, value: viewModel.transcriptioError)
        .animation(.smooth(duration: 0.1), value: viewModel.selectedPet)
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
            TranslatorView()
        case .processOfTranslation:
            processOfTranslationView
        case .result:
            ResultView()
        }
    }
    
    private var processOfTranslationView: some View {
        VStack {
            Spacer()
            Text("Process of translation...")
                .font(.customMedium)
                .padding(.bottom, 60)
        }
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
