//
//  TermsOfUseScreenView.swift
//  PetsTranslator
//
//  Created by Stas Boiko on 3/24/25.
//

import SwiftUI

struct TermsOfUseScreenView: View {
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
            Text("Terms of Use")
                .font(.customTitle)
                .frame(maxWidth: .infinity, alignment: .center)
            
            HStack {
                Text("Effective Date:")
                    .font(.customMedium)
                Text("24.03.2025")
                    .font(.customSmall)
                Spacer()
            }
            
            
            Text("""
                Welcome to "PetsTranslator" (“App”). By downloading, accessing, or using our App, you (“User”) agree to be bound by these Terms of Use (“Terms”). If you do not agree to these Terms, please do not use the App.
                """)
            
            HStack {
                Text("1. Use of the App")
                    .font(.customMedium)
                Spacer()
            }
            
            Text("""
            • The App is designed for entertainment and educational purposes only. It does not provide scientifically validated animal translations.
            • You agree to use the App only for lawful purposes and not to misuse it in any way.
            """)
            
            
            HStack {
                Text("2. User Content")
                    .font(.customMedium)
                Spacer()
            }
            
            Text("""
                • If the App allows users to submit, upload, or share content (e.g., recordings, translations), you grant us a non-exclusive, worldwide license to use, store, and display your content for App functionality.
                • You are responsible for any content you submit and must not upload harmful, offensive, or illegal material.
                """)
            
            HStack {
                Text("3. Privacy & Data Collection")
                    .font(.customMedium)
                Spacer()
            }
            
            Text("""
                • We may collect certain data to improve the App’s functionality. Please refer to our [Privacy Policy] for details on data collection, storage, and use.
                • By using the App, you consent to our data practices as described in the Privacy Policy.
                """)
            
            HStack {
                Text("4. Intellectual Property")
                    .font(.customMedium)
                Spacer()
            }
            
            Text("""
                • All intellectual property rights related to the App, including trademarks, logos, and content, belong to PetsTranslator Co. or its licensors.
                • You may not copy, modify, distribute, or reverse-engineer any part of the App without our prior written consent.
                """)
            
            HStack {
                Text("5. Disclaimers & Limitations of Liability")
                    .font(.customMedium)
                Spacer()
            }
            
            Text("""
                • The App is provided “as is” without warranties of any kind. We do not guarantee the accuracy or reliability of translations.
                • We are not liable for any direct, indirect, incidental, or consequential damages arising from your use of the App.
                • You acknowledge that the App is for entertainment purposes and should not be used for real-world animal communication or behavioral interpretation.
                """)
            
            HStack {
                Text("6. Third-Party Services")
                    .font(.customMedium)
                Spacer()
            }
            
            Text("""
                The App may contain links to third-party services. We are not responsible for the content, policies, or practices of these services.
                """)
            
            HStack {
                Text("7. Termination")
                    .font(.customMedium)
                Spacer()
            }
            
            Text("""
                We reserve the right to suspend or terminate your access to the App if you violate these Terms or engage in prohibited activities.
                """)
            
            HStack {
                Text("8. Changes to These Terms")
                    .font(.customMedium)
                Spacer()
            }
            
            Text("""
                We may update these Terms from time to time. Continued use of the App after changes means you accept the updated Terms.
                """)
            
            HStack {
                Text("9. Governing Law")
                    .font(.customMedium)
                Spacer()
            }
            
            Text("""
                These Terms are governed by the laws of Ukraine.
                """)
            
            HStack {
                Text("10. Contact Information")
                    .font(.customMedium)
                Spacer()
            }
            
            Text("""
                For any questions regarding these Terms, please contact us at:
                """)
            
            Link("boikostas3@gmail.com", destination: URL(string: "boikostas3@gmail.com")!)
                .padding(.bottom, 20)
        }
        .padding(.horizontal, 20)
    }
}

#Preview {
    TermsOfUseScreenView()
}
