//
//  Tab.swift
//  PetsTranslator
//
//  Created by Stas Boiko on 3/21/25.
//

import SwiftUI

enum Tab {
    case translator
    case settings
    
    var title: String {
        switch self {
        case .translator:
            return "Translator"
        case .settings:
            return "Settings"
        }
    }
    
    var icon: Image {
        switch self {
        case .translator:
            return Image(.translatorTabIcon)
        case .settings:
            return Image(.settingsTabIcon)
        }
    }
}
