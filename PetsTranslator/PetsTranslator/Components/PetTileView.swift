//
//  PetTileView.swift
//  PetsTranslator
//
//  Created by Stas Boiko on 3/22/25.
//

import SwiftUI

struct PetTileView: View {
    
    var pet: Pet
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 8)
                .fill(pet.tileBackgroundColor)
            
            pet.icon
                .resizable()
                .frame(width: 40, height: 40)
        }
    }
}
