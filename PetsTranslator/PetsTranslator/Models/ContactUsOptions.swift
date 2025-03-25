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
            URL(string: Constants.Url.gmailUrlString)!
        case .linkedIn:
            URL(string: Constants.Url.linkedInUrlString)!
        case .gitHub:
            URL(string: Constants.Url.gitHubProfileUrlString)!
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
