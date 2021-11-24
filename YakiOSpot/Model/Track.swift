//
//  Track.swift
//  YakiOSpot
//
//  Created by Raphaël Payet on 24/11/2021.
//

import Foundation
import SwiftUI

struct Track: Codable, Hashable {
    let id: String?
    let name: String
    var likes: Int?
    let difficulty: Difficulty
    
    enum Difficulty: String, Codable {
        case green, blue, red, black
        
        var color: Color {
            switch self {
            case .green:
                return Color.green
            case .blue:
                return Color.blue
            case .red:
                return Color.red
            case .black:
                return Color.black
            }
        }
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static let dummyTrack = Track(id: UUID().uuidString, name: "La Moria", likes: 218, difficulty: .blue)
    
    static let mockTracks = [dummyTrack, Track(id: UUID().uuidString, name: "Scred", likes: 123, difficulty: .black)]
}
