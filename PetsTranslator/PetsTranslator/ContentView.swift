//
//  ContentView.swift
//  PetsTranslator
//
//  Created by Stas Boiko on 3/21/25.
//

import SwiftUI

struct ContentView: View {
    
    @State private var selectedTab: Tab = .translator
    
    @StateObject private var translatorViewModel = TranslatorViewModel()
    
    var body: some View {
        ZStack {
            BackgroundGradient()
            
            switch selectedTab {
            case .translator:
                TranslatorScreenView()
                    .environmentObject(translatorViewModel) 
            case .settings:
                SettingsScreenView()
            }
        }
        .overlay(alignment: .bottom) {
            TabBarView(selectedTab: $selectedTab)
                .opacity(translatorViewModel.screenState == .translator ? 1 : 0)
        }
    }
}

#Preview {
    ContentView()
}
