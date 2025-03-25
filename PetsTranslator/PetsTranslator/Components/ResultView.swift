//
//  ResultView.swift
//  PetsTranslator
//
//  Created by Stas Boiko on 3/25/25.
//

import SwiftUI

struct ResultView: View {
    
    @EnvironmentObject var viewModel: TranslatorViewModel
    
    var body: some View {
        resultView
    }
    
    private var resultView: some View {
        VStack {
            resultTitle
            if viewModel.translateFrom == .pet {
                resultTextSection
            } else if viewModel.translateFrom == .human {
                resultSoundSection
            }
            Spacer()
        }
    }
    
    private var resultTitle: some View {
        ZStack {
            Text("Result")
                .font(.customTitle)
            
            //MARK: Close button
            HStack {
                Button {
                    viewModel.stopAudioPlayer()
                    viewModel.soundToPlayName = nil
                    viewModel.transcriptioError = nil
                    viewModel.screenState = .translator
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: .infinity)
                            .fill(.white)
                            .frame(width: 48, height: 48)
                        Image(.closeButtonIcon)
                            .resizable()
                            .frame(width: 28, height: 28)
                    }
                }
                Spacer()
            }
        }
        .frame(height: 58)
        .padding(.horizontal, 20)
        .padding(.bottom, 90)
        
    }
    
    private var resultSoundSection: some View {
        VStack(spacing: 20) {
            ZStack {
                RoundedRectangle(cornerRadius: 16)
                    .fill(.purpleTileBackground)
                
                Text(viewModel.translatedText)
                    .font(.customSmall)
                    .padding(20)
            }
            .shadow(color: .black.opacity(0.15), radius: 5, y: 4)
            .frame(height: 150)
            
            //MARK: Repeat button
            Button {
                if let soundName = viewModel.soundToPlayName {
                    viewModel.playSound(soundName)
                }
            } label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 16)
                        .fill(.purpleTileBackground)
                        .frame(height: 50)
                    
                    HStack(spacing: 10) {
                        Image(.repeatIcon)
                            .resizable()
                            .frame(width: 16, height: 16)
                        Text("Repeat")
                            .font(.customSmall)
                    }
                    .padding(.horizontal, 20)
                }
                .shadow(color: .black.opacity(0.15), radius: 5, y: 4)
            }
        }
        .padding(.horizontal, 50)
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
                    
                Text(viewModel.translatedText)
                    .font(.customSmall)
                    .padding(20)
            }
            .offset(y: -50)
        }
        .padding(.horizontal, 50)
    }
}
