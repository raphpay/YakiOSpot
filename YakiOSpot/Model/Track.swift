//
//  Track.swift
//  YakiOSpot
//
//  Created by Raphaël Payet on 24/11/2021.
//

import Foundation

struct Track: Codable, Hashable {
    var id: String?
    var name: String
    var likes: Int?
    
    enum Difficulty: String, Codable {
        case green, blue, red, black, diamond
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static let dummyTrack = Track(id: UUID().uuidString, name: "La Moria", likes: 218)
    
    static let mockTracks = [dummyTrack, Track(id: UUID().uuidString, name: "Scred", likes: 123)]
}
