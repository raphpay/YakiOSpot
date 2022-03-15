//
//  StatusButton.swift
//  YakiOSpot
//
//  Created by Raphaël Payet on 29/01/2022.
//

import SwiftUI

struct StatusButton: View {
    @Binding var isSelected: Bool
    let title: String
    let color: Color
    let action: (() -> Void)?
    
    var body: some View {
        Button {
            action?()
        } label: {
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
        .disabled(isSelected)
    }
}
