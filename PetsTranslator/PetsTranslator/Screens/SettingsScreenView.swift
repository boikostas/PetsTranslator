//
//  SettingsScreenView.swift
//  PetsTranslator
//
//  Created by Stas Boiko on 3/21/25.
//

import SwiftUI

struct SettingsScreenView: View {
    var body: some View {
        VStack {
            Text(Tab.settings.title)
                .font(.customTitle)
            
            Spacer()
        }
        .padding(.vertical, 12)
    }
}

#Preview {
    SettingsScreenView()
}
