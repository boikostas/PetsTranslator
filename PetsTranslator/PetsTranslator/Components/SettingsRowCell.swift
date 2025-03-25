//
//  SettingsRowCell.swift
//  PetsTranslator
//
//  Created by Stas Boiko on 3/23/25.
//

import SwiftUI

struct SettingsRowCell: View {
    
    var rowType: SettingsRowType
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(.purpleTileBackground)
            HStack {
                Text(rowType.rawValue)
                    .font(.customMedium)
                    .foregroundStyle(.appTint)
                Spacer()
                Image(.arrowRightIcon)
                    .resizable()
                    .frame(width: 24, height: 24)
            }
            .foregroundStyle(.appTint)
            .padding(.horizontal, 16)
        }
        .frame(height: 50)
    }
}

#Preview {
    SettingsRowCell(rowType: .rateUs)
}
