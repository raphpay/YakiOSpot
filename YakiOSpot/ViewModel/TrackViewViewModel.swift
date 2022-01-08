//
//  TrackViewViewModel.swift
//  YakiOSpot
//
//  Created by Raphaël Payet on 31/12/2021.
//

import Foundation

final class TrackViewViewModel: ObservableObject {
    @Published var track = DummySpot.cornillon.tracks[0]
    @Published var player: Player
    
    init(track: Track) {
        self.track = track
        player = Player(videoURL: track.videoURL)
    }
    
    func stop() {
        player.stop()
    }
}
