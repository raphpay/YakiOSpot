//
//  BikeRow.swift
//  YakiOSpot
//
//  Created by Raphaël Payet on 29/01/2022.
//

import SwiftUI

struct BikeRow: View {
    var body: some View {
        HStack {
            Image(Assets.placeholderBike)
                .resizable()
                .frame(width: 100, height: 100)
                .aspectRatio(contentMode: .fill)
                .mask(RoundedRectangle(cornerRadius: 20))
            
            Text("Scott Genius 920")
                .font(.title3)
            
            Spacer()
            Image(systemName: "highlighter")
                .font(.system(size: 25))
                .foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity, alignment: .center)
        .padding(.horizontal)
    }
}
