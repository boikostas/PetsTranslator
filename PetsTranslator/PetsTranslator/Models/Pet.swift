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
    
    var translationsOfSounds: [String] {
        switch self {
        case .cat:
            [
                "I’m hungry, feed me!",
                "Stay away, I’m angry!",
                "Where have you been?",
                "Open the door, I want to go outside!",
                "Pay attention to me!",
                "I’m warning you, don’t mess with me!",
                "I love you!"
            ]
        case .dog:
            [
                "Hello, nice to see you!",
                "Back off, I don’t like this!",
                "Come play with me!",
                "I’m happy and excited!",
                "Alert! Someone’s here!",
                "I’m investigating something interesting!",
                "What are you doing, human?",
                "It's time to eat!"
            ]
        }
    }
}
