//
//  PrivacyPolicyScreenView.swift
//  PetsTranslator
//
//  Created by Stas Boiko on 3/23/25.
//

import SwiftUI

struct PrivacyPolicyScreenView: View {
    var body: some View {
        ZStack {
            BackgroundGradient()
                
            VStack {
                RoundedRectangle(cornerRadius: .infinity)
                    .frame(width: 30, height: 5)
                    .opacity(0.1)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding(.top, 20)
                
                ScrollView {
                    textSection
                }
                .padding(.bottom, 8)
            }
        }
    }
    
    private var textSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Privacy Policy")
                .font(.customTitle)
                .frame(maxWidth: .infinity, alignment: .center)
            
            VStack {
                HStack {
                    Text("Effective Date:")
                        .font(.customMedium)
                    Text("24.03.2025")
                        .font(.customSmall)
                    Spacer()
                }
                
                HStack {
                    Text("Last Updated:")
                        .font(.customMedium)
                    Text("24.03.2025")
                        .font(.customSmall)
                    Spacer()
                }
            }
            
            Text("""
                "PetsTranslator" (“we,” “our,” or “us”) respects your privacy. This Privacy Policy explains how we collect, use, and protect your information when you use our mobile application (“App”).
                """)
            
            HStack {
                Text("1. Information We Collect")
                    .font(.customMedium)
                Spacer()
            }
            
            
            Text("We may collect the following types of data when you use our App:")
            
            HStack {
                Text("a. Personal Information")
                    .font(.customMedium)
                Spacer()
            }
            
            Text("""
                • If you provide feedback or contact us, we may collect your name and email address.
                """)
            
            HStack {
                Text("b. Non-Personal Information")
                    .font(.customMedium)
                Spacer()
            }
            
            Text("""
                • Device information (model, OS version, unique device identifiers).
                • App usage data (such as interactions and feature usage).
                """)
            
            HStack {
                Text("c. Audio Data")
                    .font(.customMedium)
                Spacer()
            }
            
            Text("""
                • The App processes your voice and animal sounds locally on your device.
                • We do not store or transmit audio recordings unless explicitly stated.
                """)
            
            HStack {
                Text("2. How We Use Your Information")
                    .font(.customMedium)
                Spacer()
            }
            
            Text("""
                We use the collected data to:
                    • Provide and improve the translation functionality.
                    • Enhance user experience and app performance.
                    • Respond to customer inquiries and support requests.
                """)
            
            HStack {
                Text("3. Data Storage & Security")
                    .font(.customMedium)
                Spacer()
            }
            
            Text("""
                • We do not collect or store audio data on our servers.
                • Personal information (if collected) is protected using industry-standard security measures.
                """)
            
            HStack {
                Text("4. Third-Party Services")
                    .font(.customMedium)
                Spacer()
            }
            
            Text("""
                • We may use analytics services (e.g., Google Analytics, Firebase) to understand app usage.
                • These services may collect anonymous usage data as outlined in their privacy policies.
                """)
            
            HStack {
                Text("5. Your Rights & Choices")
                    .font(.customMedium)
                Spacer()
            }
            
            Text("""
                • You can request access, modification, or deletion of your personal data.
                • You can disable microphone access through device settings if you do not wish to use the translation feature.
                """)
            
            HStack {
                Text("6. Changes to This Policy")
                    .font(.customMedium)
                Spacer()
            }
            
            Text("""
                We may update this Privacy Policy from time to time. We will notify you of any significant changes within the App or via email (if applicable).
                """)
            
            HStack {
                Text("7. Contact Us")
                    .font(.customMedium)
                Spacer()
            }
            
            Text("""
                If you have any questions about this Privacy Policy, you can contact us at:
                """)
            
            Link("boikostas3@gmail.com", destination: URL(string: Constants.Url.gmailUrlString)!)
                .padding(.bottom, 20)
        }
        .padding(.horizontal, 20)
    }
}

#Preview {
    PrivacyPolicyScreenView()
}
