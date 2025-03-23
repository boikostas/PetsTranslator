//
//  Pet.swift
//  PetsTranslator
//
//  Created by Stas Boiko on 3/22/25.
//

import SwiftUI

enum Pet {
    case cat
    case dog
    
    var icon: Image {
        switch self {
        case .cat:
            Image(.catIcon)
        case .dog:
            Image(.dogIcon)
        }
    }
    
    var tileBackgroundColor: Color {
        switch self {
        case .cat:
                .catTileBackground
        case .dog:
                .dogTileBackground
        }
    }
}
