//
//  BubbleMassageShape.swift
//  PetsTranslator
//
//  Created by Stas Boiko on 3/24/25.
//

import SwiftUI

struct BubbleMassageShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        let cornerRadius: CGFloat = 16
        let tailWidth: CGFloat = 10
        
        let bubbleRect = CGRect(x: 0, y: 0, width: rect.width, height: rect.height * 0.6)
        path.addRoundedRect(in: bubbleRect, cornerSize: CGSize(width: cornerRadius, height: cornerRadius))
        
        let tailStart = CGPoint(x: rect.width * 0.85, y: bubbleRect.maxY)
        let tailTip = CGPoint(x: rect.width * 0.65, y: rect.height)
        let tailEnd = CGPoint(x: rect.width * 0.89 + tailWidth, y: bubbleRect.maxY)

        path.move(to: tailStart)
        path.addLine(to: tailTip)
        path.addLine(to: tailEnd)
        path.closeSubpath()

        return path
    }
}

#Preview {
    BubbleMassageShape()
        .frame(height: 250)
}
