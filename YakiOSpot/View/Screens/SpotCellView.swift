//
//  SpotCellView.swift
//  YakiOSpot
//
//  Created by Raphaël Payet on 14/11/2021.
//

import SwiftUI

struct SpotCellView: View {
    var spot: Spot
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Button {
                    didTapStarButton()
                } label: {
                    Image(systemName: spot.isFavorited ? "star.fill" : "star")
                        .foregroundColor(.yellow)
                }

                Spacer()
                Text(spot.name)
                    .font(.title2)
                Spacer()
            }
            
            Label("\(spot.tracks.count) Pistes", systemImage: "bicycle")
                .foregroundColor(.black)
                .padding(.top, 5)
            Label("\(spot.members) Membres", systemImage: "person.3")
                .foregroundColor(.black)
                .padding(.top, 5)
            Label("\(spot.peoplePresent) Présents", systemImage: "hand.raised")
                .foregroundColor(.black)
                .padding(.top, 5)
        }
    }
    
    func didTapStarButton() {
        // Find the spot ID
        // Check if the ID is in the users favorited spots
        // Star or unstar
        // Toggle on firebase
        print("didTapStarButton")
    }
}


struct SpotCellView_Previews: PreviewProvider {
    static var previews: some View {
        SpotCellView(spot: Spot.dummySpot)
    }
}
