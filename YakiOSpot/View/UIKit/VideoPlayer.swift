//
//  VideoPlayer.swift
//  
//
//  Created by Raphaël Payet on 18/12/2021.
//

import SwiftUI
import AVKit

struct Player: UIViewControllerRepresentable {
    
    var videoRessource: URL
    var player: AVPlayer
    
    init(videoName: String?) {
        if let name = videoName,
           let path = Bundle.main.path(forResource: name, ofType: "mp4") {
            let url = URL(fileURLWithPath: path)
            videoRessource = url
            player = AVPlayer(url: videoRessource)
        } else {
            videoRessource = URL(string: "https://bit.ly/swswift")!
            player = AVPlayer(url: videoRessource)
        }
    }

    func makeUIViewController(context: Context) -> AVPlayerViewController {

        let controller = AVPlayerViewController()
        controller.player = player

        return controller
    }

    func updateUIViewController(_ uiViewController: AVPlayerViewController, context:  Context) {}
    
    func stop() {
        player.pause()
    }
}
