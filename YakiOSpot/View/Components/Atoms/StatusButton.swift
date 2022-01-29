//
//  StatusButton.swift
//  YakiOSpot
//
//  Created by Raphaël Payet on 29/01/2022.
//

import SwiftUI

struct StatusButton: View {
    
    let title: String
    let color: Color
    let isSelected: Bool
    
    init(title: String = "🚵‍♂️ Au spot", color: Color = .green, isSelected: Bool = true) {
        self.title = title
        self.color = color
        self.isSelected = isSelected
    }
    
    var body: some View {
        Text(title)
            .foregroundColor(.white)
            .font(.title3)
            .fontWeight(.bold)
            .frame(minWidth: 126)
            .frame(maxHeight: 41)
            .padding()
            .overlay(RoundedRectangle(cornerRadius: 20, style: .continuous).blendMode(.overlay))
            .background(color)
            .mask(RoundedRectangle(cornerRadius: 20, style: .continuous))
            .overlay(isSelected ? nil : RoundedRectangle(cornerRadius: 20, style: .continuous).foregroundColor(.white.opacity(0.5)))
            .shadow(radius: 8)
    }
}
