//
//  SheetViewTopIndicatorView.swift
//  PetsTranslator
//
//  Created by Stas Boiko on 3/25/25.
//

import SwiftUI

struct SheetViewTopIndicatorView: View {
    var body: some View {
        RoundedRectangle(cornerRadius: .infinity)
            .frame(width: 30, height: 5)
            .opacity(0.1)
            .frame(maxWidth: .infinity, alignment: .center)
            .padding(.top, 20)
    }
}

#Preview {
    SheetViewTopIndicatorView()
}
