//
//  SettingsRowType.swift
//  PetsTranslator
//
//  Created by Stas Boiko on 3/23/25.
//

import Foundation

enum SettingsRowType: String, CaseIterable, Identifiable {
    case rateUs = "Rate Us"
    case shareApp = "Share App"
    case contactUs = "Contact Us"
    case restorePurchases = "Restore Purchases"
    case privacyPolicy = "Privacy Policy"
    case termsOfUse = "Terms of Use"
    
    var id: String {
        self.rawValue
    }
}
