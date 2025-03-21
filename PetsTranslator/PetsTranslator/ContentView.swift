//
//  ContentView.swift
//  PetsTranslator
//
//  Created by Stas Boiko on 3/21/25.
//

import SwiftUI

struct ContentView: View {
    
    @State private var selectedTab: Tab = .translator
    
    var body: some View {
        ZStack {
            LinearGradient(colors: [.gradientTop, .gradientBottom], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            
            switch selectedTab {
            case .translator:
                TranslatorScreenView()
            case .settings:
                SettingsScreenView()
            }
        }
        .overlay(alignment: .bottom) {
            ZStack {
                RoundedRectangle(cornerRadius: 16)
                    .fill(Color.white)
                    .frame(width: 216, height: 82)
                
                HStack(spacing: 42) {
                    Button {
                        selectedTab = .translator
                    } label: {
                        TabView(tab: .translator)
                        .opacity(selectedTab == .translator ? 1 : 0.3)
                    }
                    .tint(.appTint)
                    
                    Button {
                        selectedTab = .settings
                    } label: {
                        TabView(tab: .settings)
                        .opacity(selectedTab == .settings ? 1 : 0.3)
                    }
                    .tint(.appTint)
                }
            }
            .padding(.bottom, 16)
        }
        
    }
}

#Preview {
    ContentView()
}
