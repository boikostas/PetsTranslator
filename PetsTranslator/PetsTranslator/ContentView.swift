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
            BackgroundGradient()
            
            switch selectedTab {
            case .translator:
                TranslatorScreenView()
            case .settings:
                SettingsScreenView()
            }
        }
        .overlay(alignment: .bottom) {
            TabBarView(selectedTab: $selectedTab)
        }
    }
}

#Preview {
    ContentView()
}
