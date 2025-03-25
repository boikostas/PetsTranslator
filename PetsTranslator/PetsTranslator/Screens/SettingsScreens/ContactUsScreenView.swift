//
//  ContactUsScreenView.swift
//  PetsTranslator
//
//  Created by Stas Boiko on 3/24/25.
//

import SwiftUI

struct ContactUsScreenView: View {
    var body: some View {
        ZStack {
            BackgroundGradient()
            
            VStack {
                RoundedRectangle(cornerRadius: .infinity)
                    .frame(width: 30, height: 5)
                    .opacity(0.1)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding(.top, 20)
                
                Text("Contact Us")
                    .font(.customTitle)
                    .frame(maxWidth: .infinity, alignment: .center)
                
                ForEach(ContactUsOptions.allCases) { option in
                    linkToContactUsOption(option)
                }
                Spacer()
            }
            .padding(.horizontal)
        }
        .foregroundStyle(.appTint)
    }
    
    @ViewBuilder
    private func linkToContactUsOption(_ option: ContactUsOptions) -> some View {
        Link(destination: option.url) {
            ZStack {
                RoundedRectangle(cornerRadius: 16)
                    .fill(.white)
                    .frame(height: 50)
                
                HStack(spacing: 10) {
                    option.icon
                        .resizable()
                        .frame(width: 25, height: 25)
                        .clipShape(.rect(cornerRadius: 8))
                        .shadow(color: .black.opacity(0.15), radius: 5)
                    
                    Text(option.rawValue)
                        .font(.customText)
                    
                    Spacer()
                    
                    Image(.arrowRightIcon)
                }
                .padding(.horizontal)
            }
            .shadow(color: .black.opacity(0.15), radius: 5, y: 4)
        }
    }
}

#Preview {
    ContactUsScreenView()
}
