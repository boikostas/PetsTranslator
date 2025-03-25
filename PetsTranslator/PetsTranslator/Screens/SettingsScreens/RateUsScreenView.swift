//
//  RateUsScreenView.swift
//  PetsTranslator
//
//  Created by Stas Boiko on 3/25/25.
//

import SwiftUI

struct RateUsScreenView: View {
    
    @AppStorage("rating") var rating = 0
    
    private var underRatingLabel: String {
        if rating == 0 {
            "This will help us to improve our app"
        } else {
            "Thanks for your feedback! You can always change your decision."
        }
    }
    
    var body: some View {
        ZStack {
            BackgroundGradient()
            
            VStack(spacing: 30) {
                SheetViewTopIndicatorView()
                
                Text("Rate Us")
                    .font(.customTitle)
                    .frame(maxWidth: .infinity, alignment: .center)
                
                HStack(spacing: 12) {
                    ForEach(1..<6) { index  in
                        Image(systemName: "star.fill")
                            .resizable()
                            .frame(width: 40, height: 40)
                            .foregroundStyle(index > rating ? .appTint.opacity(0.3) : .yellow)
                            .onTapGesture {
                                rating = index
                            }
                    }
                }
                
                Text(underRatingLabel)
                    .font(.customSmall)
                    .multilineTextAlignment(.center)
                
                Spacer()
            }
            .padding(.horizontal)
        }
        .foregroundStyle(.appTint)
        .animation(.easeInOut, value: rating)
    }
}

#Preview {
    RateUsScreenView()
}
