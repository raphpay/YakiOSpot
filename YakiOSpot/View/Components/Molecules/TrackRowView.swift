//
//  TrackRowView.swift
//  YakiOSpot
//
//  Created by Raphaël Payet on 24/11/2021.
//

import SwiftUI

struct TrackRowView: View {
    var track: Track
    
    var body: some View {
        HStack {
            Image(systemName: "flag.fill")
                .foregroundColor(track.difficulty.color)
            Spacer()
            
            Text(track.name)
            Spacer()
            
            HStack {
                Image(systemName: "hand.thumbsup.fill")
                    .foregroundColor(.blue)
                Text("\(track.likes ?? 0)")
            }
        }
    }
}

struct TrackRowView_Previews: PreviewProvider {
    static var previews: some View {
        TrackRowView(track: Track.dummyTrack)
    }
}
