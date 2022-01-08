//
//  VideoPlayer.swift
//  
//
//  Created by Raphaël Payet on 18/12/2021.
//

import SwiftUI
import AVKit

struct Player: UIViewControllerRepresentable {
    
    var videoRessource: URL?
    var player: AVPlayer?
    
    init(videoURL: URL?) {
        if let videoURL = videoURL {
            videoRessource = videoURL
            player = AVPlayer(url: videoRessource!)
        } else {
            videoRessource = nil
            player = nil
        }
    }

    func makeUIViewController(context: Context) -> AVPlayerViewController {

        let controller = AVPlayerViewController()
        controller.player = player

        return controller
    }

    func updateUIViewController(_ uiViewController: AVPlayerViewController, context:  Context) {}
    
    func stop() {
        player?.pause()
    }
}
