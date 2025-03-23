//
//  TranslatorScreenView.swift
//  PetsTranslator
//
//  Created by Stas Boiko on 3/21/25.
//

import SwiftUI

enum CharacterType: String {
    case human = "HUMAN"
    case pet = "PET"
}

struct TranslatorScreenView: View {
    
    @State private var selectedPet: Pet = .cat
    @State private var translateFrom: CharacterType = .human
    
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
        .animation(.easeInOut, value: selectedPet)
        .animation(.smooth(duration: 0.1), value: translateFrom) 
    }
    
    private var title: some View {
        Text(Tab.translator.title)
            .font(.customTitle)
            .frame(height: 58)
    }
    
    private var swapCharactersSection: some View {
        HStack(spacing: 8) {
            Text(translateFrom == .human ? CharacterType.human.rawValue : CharacterType.pet.rawValue)
                .frame(width: 135, height: 61)
            
            Button {
                switch translateFrom {
                case .human:
                    translateFrom = .pet
                case .pet:
                    translateFrom = .human
                }
            } label: {
                Image(.arrowSwapIcon)
                    .resizable()
                    .frame(width: 24, height: 24)
            }
            
            Text(translateFrom == .human ? CharacterType.pet.rawValue : CharacterType.human.rawValue)
                .frame(width: 135, height: 61)
        }
        .font(.customMedium)
        .padding(.top, 12)
    }
    
    private var speakSection: some View {
        HStack(spacing: 35) {
            Button {
                
            } label: {
                ZStack(alignment: .bottom) {
                    RoundedRectangle(cornerRadius: 16)
                        .fill(.white)
                        .shadow(color: .black.opacity(0.25), radius: 5, y: 4)
                        .frame(width: 178)
                    
                    VStack(spacing: 24) {
                        Image(.microphoneIcon)
                            .resizable()
                            .frame(width: 70, height: 70)
                        
                        Text("Start Speak")
                            .font(.customMedium)
                    }
                    .padding(.bottom, 12)
                }
            }
            
            ZStack {
                RoundedRectangle(cornerRadius: 16)
                    .fill(.white)
                    .shadow(color: .black.opacity(0.25), radius: 5, y: 4)
                
                VStack(spacing: 12){
                    Button {
                        selectedPet = .cat
                    } label: {
                        PetTileView(pet: .cat)
                            .opacity(selectedPet == .cat ? 1 : 0.5)
                    }
                    
                    Button {
                        selectedPet = .dog
                    } label: {
                        PetTileView(pet: .dog)
                            .opacity(selectedPet == .dog ? 1 : 0.5)
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
        selectedPet.icon
            .resizable()
            .frame(width: 184, height: 184)
    }
}

#Preview {
    TranslatorScreenView()
}
