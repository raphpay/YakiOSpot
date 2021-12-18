//
//  VideoPlayer.swift
//  
//
//  Created by Raphaël Payet on 18/12/2021.
//

import SwiftUI
import AVKit

struct Player: UIViewControllerRepresentable {

    func makeUIViewController(context: UIViewControllerRepresentableContext<Player>) -> AVPlayerViewController {

        let player = AVPlayer(url: URL(string: "https://bit.ly/swswift")!)
        let controller = AVPlayerViewController()
        controller.player = player

        return controller
    }

    func updateUIViewController(_ uiViewController: AVPlayerViewController, context:  UIViewControllerRepresentableContext<Player>) {}
}
