//
//  SpotView.swift
//  YakiOSpot
//
//  Created by Raphaël Payet on 14/11/2021.
//

import SwiftUI

struct SpotView: View {
    var spot: Spot
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image(systemName: "star.fill")
                    .foregroundColor(.yellow)
                Spacer()
                Text(spot.name)
                    .font(.title2)
                Spacer()
            }
            
            Label("\(spot.tracks) Pistes", systemImage: "bicycle")
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
}


struct SpotView_Previews: PreviewProvider {
    static var previews: some View {
        SpotView(spot: Spot.dummySpot)
    }
}
