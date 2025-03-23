//
//  TabBarView.swift
//  PetsTranslator
//
//  Created by Stas Boiko on 3/22/25.
//

import SwiftUI

struct TabBarView: View {
    
    @Binding var selectedTab: Tab
    
    var body: some View {
        tabBar
    }
    
    private var tabBar: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.white)
                .frame(width: 216, height: 82)
            
            HStack(spacing: 42) {
                Button {
                    selectedTab = .translator
                } label: {
                    TabBarItemView(tab: .translator)
                    .opacity(selectedTab == .translator ? 1 : 0.3)
                }
                .tint(.appTint)
                
                Button {
                    selectedTab = .settings
                } label: {
                    TabBarItemView(tab: .settings)
                    .opacity(selectedTab == .settings ? 1 : 0.3)
                }
                .tint(.appTint)
            }
        }
        .padding(.bottom, 16)
    }
}

