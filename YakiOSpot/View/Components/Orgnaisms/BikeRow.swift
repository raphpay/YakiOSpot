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
    @EnvironmentObject private var profileState: ProfileState
    @Binding var showBikeCreation: Bool
    
    var body: some View {
        if viewModel.bike.model == "" {
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
            AnimatedImage(data: profileState.bikeImageData)
                .resizable()
                .placeholder(UIImage(named: Assets.noBike))
                .bikeImageStyle()
            
            Text(viewModel.bike.model)
                .font(.title3)
            
            Spacer()
            Button {
                showBikeCreation = true
            } label: {
                Image(systemName: "highlighter")
                    .font(.system(size: 25))
                    .foregroundColor(.secondary)
            }

            NavigationLink(destination: BikeCreationView(), isActive: $showBikeCreation) { }

        }
        .frame(maxWidth: .infinity, alignment: .center)
        .padding(.horizontal)
    }
}
