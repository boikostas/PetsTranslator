//
//  RestorePurchasesScreenView.swift
//  PetsTranslator
//
//  Created by Stas Boiko on 3/25/25.
//

import SwiftUI

struct RestorePurchasesScreenView: View {
    var body: some View {
        ZStack {
            BackgroundGradient()
            
            VStack(spacing: 30) {
                SheetViewTopIndicatorView()
                
                Text("Restore Purchases")
                    .font(.customTitle)
                    .frame(maxWidth: .infinity, alignment: .center)
               
                Text("Here will be your cancelled purchases")
                    .font(.customMedium)
                    .foregroundStyle(.appTint.opacity(0.3))
                
                Spacer()
            }
            .padding(.horizontal)
        }
        .foregroundStyle(.appTint)
    }
}

#Preview {
    RestorePurchasesScreenView()
}
