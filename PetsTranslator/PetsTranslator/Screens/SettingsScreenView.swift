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
        .sheet(item: $sheetToShow) { sheet in
            buildSheetView(sheet)
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
                    if let url = URL(string: Constants.Url.gitHubAppUrlString) {
                        ShareLink(item: url) {
                            SettingsRowCell(rowType: rowType)
                        }
                    }
                } else {
                    Button {
                        sheetToShow = rowType
                    } label: {
                        SettingsRowCell(rowType: rowType)
                    }
                }
            }
        }
    }
    
    @ViewBuilder
    private func buildSheetView(_ sheet: SettingsRowType) -> some View {
        switch sheet {
        case .rateUs:
            Text("Rate")
                .presentationDetents([.height(100)])
        case .shareApp:
            EmptyView()
        case .contactUs:
            ContactUsScreenView()
                .presentationDetents([.medium])
        case .restorePurchases:
            Text("Purchase")
        case .privacyPolicy:
            PrivacyPolicyScreenView()
        case .termsOfUse:
            TermsOfUseScreenView()
        }
    }
}

#Preview {
    SettingsScreenView()
}
