//
//  BikeRow.swift
//  YakiOSpot
//
//  Created by Raphaël Payet on 29/01/2022.
//

import SwiftUI
import SDWebImage

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
            if let imageData = viewModel.imageData {
                Image(uiImage: UIImage(data: imageData)!)
                    .resizable()
                    .frame(width: 100, height: 100)
                    .aspectRatio(contentMode: .fill)
                    .mask(RoundedRectangle(cornerRadius: 20))
            } else {
                Image(Assets.noBike)
                    .resizable()
                    .frame(width: 100, height: 100)
                    .aspectRatio(contentMode: .fill)
                    .mask(RoundedRectangle(cornerRadius: 20))
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
