//
//  TranslatorScreenView.swift
//  PetsTranslator
//
//  Created by Stas Boiko on 3/21/25.
//

import SwiftUI

struct TranslatorScreenView: View {
    
    var body: some View {
        VStack {
            Text(Tab.translator.title)
                .font(.customTitle)
                .foregroundStyle(.appTint)
            
            Spacer()
        }
        .padding(.vertical, 12)
    }
}

#Preview {
    TranslatorScreenView()
}
