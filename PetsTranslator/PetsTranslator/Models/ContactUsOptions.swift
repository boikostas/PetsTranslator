//
//  ContactUsOptions.swift
//  PetsTranslator
//
//  Created by Stas Boiko on 3/25/25.
//

import SwiftUI

enum ContactUsOptions: String, CaseIterable, Identifiable {
    case gmail = "Gmail"
    case linkedIn = "LinkedIn"
    case gitHub = "GitHub"
    
    var url: URL {
        switch self {
        case .gmail:
            URL(string: "mailto:boikostas3@gmail.com")!
        case .linkedIn:
            URL(string: "https://www.linkedin.com/in/stas-boiko/")!
        case .gitHub:
            URL(string: "https://github.com/boikostas")!
        }
    }
    
    var icon: Image {
        switch self {
        case .gmail:
            Image(.gmailIcon)
        case .linkedIn:
            Image(.linkedInIcon)
        case .gitHub:
            Image(.githubIcon)
        }
    }
    
    var id: String {
        self.rawValue
    }
}
