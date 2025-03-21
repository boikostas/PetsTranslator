//
//  TabView.swift
//  PetsTranslator
//
//  Created by Stas Boiko on 3/21/25.
//

import SwiftUI

struct TabView: View {
    
    var tab: Tab
    
    var body: some View {
        VStack(spacing: 4) {
            tab.icon
                .resizable()
                .frame(width: 24, height: 24)
            Text(tab.title)
                .font(.customSmall)
        }
    }
}
