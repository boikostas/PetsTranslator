//
//  ContentView.swift
//  PetsTranslator
//
//  Created by Stas Boiko on 3/21/25.
//

import SwiftUI

enum Tab {
    case translator
    case settings
    
    var title: String {
        switch self {
        case .translator:
            return "Translator"
        case .settings:
            return "Settings"
        }
    }
    
    var icon: Image {
        switch self {
        case .translator:
            return Image(.translatorTabIcon)
        case .settings:
            return Image(.settingsTabIcon)
        }
    }
}

struct ContentView: View {
    
    @State private var selectedTab: Tab = .translator
    
    var body: some View {
        ZStack {
            LinearGradient(colors: [.gradientTop, .gradientBottom], startPoint: .top, endPoint: .bottom)
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
            .padding(.bottom, 46)
        }
        .ignoresSafeArea()
    }
}

#Preview {
    ContentView()
}
