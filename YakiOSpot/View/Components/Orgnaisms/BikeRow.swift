//
//  BikeRow.swift
//  YakiOSpot
//
//  Created by Raphaël Payet on 29/01/2022.
//

import SwiftUI
import SDWebImageSwiftUI

struct BikeRow: View {
    
    @StateObject private var viewModel = BikeRowViewModel()
    
    var body: some View {
        if viewModel.bike == nil {
            emptyBikeRow
        } else {
            content
        }
    }
    
    var emptyBikeRow: some View {
        HStack(alignment: .center, spacing: 8) {
            Image(Assets.noBike)
                .resizable()
                .frame(width: 101, height: 110)
            
            Text("Pas de vélo enregistré")
        }
    }
    
    var content: some View {
        HStack {
            if let imageURL = viewModel.bike?.photoURL {
                WebImage(url: URL(string: imageURL))
                    .resizable()
                    .placeholder(Image(Assets.noBike))
                    .bikeImageStyle()
            } else {
                Image(Assets.noBike)
                    .resizable()
                    .bikeImageStyle()
            }
            
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
