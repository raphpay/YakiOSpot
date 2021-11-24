//
//  SpotView.swift
//  YakiOSpot
//
//  Created by Raphaël Payet on 15/11/2021.
//

import SwiftUI

struct SpotView: View {
    
    var spot: Spot
    @State var selection: Int = 0
    
    var tracks: [Track] = Track.mockTracks
    
    var body: some View {
        VStack {
            Picker("Selection", selection: $selection) {
                Text("Infos importantes").tag(0)
                Text("Feed").tag(1)
            }
            .pickerStyle(.segmented)
            .padding(.horizontal)
            
            if selection == 0 {
                SpotInfoView(tracks: tracks)
            } else if selection == 1 {
                SpotFeedView()
            }
            Spacer()
        }.navigationTitle(spot.name)
    }
}

struct SpotView_Previews: PreviewProvider {
    static var previews: some View {
        SpotView(spot: Spot.dummySpot)
    }
}
