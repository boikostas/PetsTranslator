//
//  SettingsScreenView.swift
//  PetsTranslator
//
//  Created by Stas Boiko on 3/21/25.
//

import SwiftUI

struct SettingsScreenView: View {
    
    @State private var sheetToShow: SettingsRowType?
    
    var body: some View {
        VStack(spacing: 12) {
            title
            rowsSection
            Spacer()
        }
        .padding(.vertical, 12)
        .padding(.horizontal, 20)
        .sheet(item: $sheetToShow) {_ in
            switch sheetToShow {
            case .rateUs:
                Text("Rate")
                    .presentationDetents([.height(100)])
            case .shareApp:
                EmptyView()
            case .contactUs:
                Text("Contacts")
                    .presentationDetents([.height(150)])
            case .restorePurchases:
                Text("Purchase")
            case .privacyPolicy:
                Text("Privacy Policy")
            case .termsOfUse:
                Text("Terms of Use")
            case nil:
                EmptyView()
            
            }
        }
    }
    
    private var title: some View {
        Text(Tab.settings.title)
            .font(.customTitle)
            .foregroundStyle(.appTint)
            .frame(height: 60)
    }
    
    private var rowsSection: some View {
        VStack(spacing: 14) {
            ForEach(SettingsRowType.allCases) { rowType in
                if rowType == .shareApp {
                    if let url = URL(string: "https://github.com/boikostas/PetsTranslator") {
                        ShareLink(item: url) {
                            SettingsRowCell(rowType: rowType)
                        }
                    }
                } else {
                    Button {
                        switch rowType {
                        case .rateUs:
                            sheetToShow = .rateUs
                        case .shareApp:
                            break
                        case .contactUs:
                            sheetToShow = .contactUs
                        case .restorePurchases:
                            sheetToShow = .restorePurchases
                        case .privacyPolicy:
                            sheetToShow = .privacyPolicy
                        case .termsOfUse:
                            sheetToShow = .termsOfUse
                        }
                    } label: {
                        SettingsRowCell(rowType: rowType)
                    }
                }
            }
        }
    }
}

#Preview {
    SettingsScreenView()
}
