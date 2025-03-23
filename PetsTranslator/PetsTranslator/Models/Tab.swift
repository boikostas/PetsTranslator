//
//  Tab.swift
//  PetsTranslator
//
//  Created by Stas Boiko on 3/22/25.
//

import SwiftUI

enum Tab {
    case translator
    case settings
    
    var title: String {
        switch self {
        case .translator:
            "Translator"
        case .settings:
            "Settings"
        }
    }
    
    var icon: Image {
        switch self {
        case .translator:
            Image(.translatorTabIcon)
        case .settings:
            Image(.settingsTabIcon)
        }
    }
}
