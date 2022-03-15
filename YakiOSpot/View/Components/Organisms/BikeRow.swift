//
//  BikeRow.swift
//  YakiOSpot
//
//  Created by Raphaël Payet on 29/01/2022.
//

import SwiftUI
import SDWebImageSwiftUI

struct BikeRow: View {
    
    @ObservedObject var profileState: ProfileState
    
    var body: some View {
        if profileState.bike.model == "" {
            emptyBikeRow
        } else {
            content
        }
    }
    
    var content: some View {
        HStack {
            if let bikeURL = profileState.bike.photoURL {
                WebImage(url: URL(string: bikeURL))
                    .resizable()
                    .placeholder(Image(Assets.noBike))
                    .aspectRatio(contentMode: .fill)
                    .bikeImageStyle()
            } else {
                placeholderImage
            }
            
            Text(profileState.bike.model)
                .font(.title3)
            
            Spacer()
            Button {
                profileState.showBikeCreation = true
            } label: {
                Image(systemName: "highlighter")
                    .font(.system(size: 25))
                    .foregroundColor(.secondary)
            }
            NavigationLink(destination: BikeCreationView(profileState: profileState), isActive: $profileState.showBikeCreation) { }
        }
        .frame(maxWidth: .infinity, alignment: .center)
        .padding(.horizontal)
    }
    
    var placeholderImage : some View {
        Image(Assets.noBike)
            .resizable()
            .bikeImageStyle()
    }
    
    var emptyBikeRow: some View {
        HStack(alignment: .center, spacing: 8) {
            Image(Assets.noBike)
                .bikeImageStyle()
            
            Text("Pas de vélo enregistré")
        }
    }
}
