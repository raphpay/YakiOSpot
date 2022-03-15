//
//  ViewModifier+Ext.swift
//  YakiOSpot
//
//  Created by Raphaël Payet on 10/02/2022.
//

import SwiftUI

struct BikeImage: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(width: 100, height: 100)
            .aspectRatio(contentMode: .fill)
            .clipShape(RoundedRectangle(cornerRadius: 20))
    }
}

extension View {
    func bikeImageStyle() -> some View {
        modifier(BikeImage())
    }
}
