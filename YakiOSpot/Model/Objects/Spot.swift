//
//  Spot.swift
//  YakiOSpot
//
//  Created by Raphaël Payet on 14/11/2021.
//

import Foundation
import UIKit

// TODO: Update the documentation

/**
The spot documentation
 
 # Parameters :
    - `id: A unique identifier. Set when creating a user`
    - `pseudo: The pseudo of the user. Set when creating a user.`
    - `mail: The email of the user. Set when creating a user.`
*/

struct Spot: Codable, Hashable {
    var id: String
    var name: String
    var tracks: [Track]
    var members: Int
    var peoplePresent: [User]?
//    var favorites: Int?
//    var isFavorited: Bool = false
    
   func hash(into hasher: inout Hasher) {
       hasher.combine(id)
   }
}


struct DummySpot {
    // Tracks
    static let slake = Track(id: UUID().uuidString, name: "Slake", difficulty: .green, likes: 0,
                             distance: nil, averageTime: nil)
    static let oldSchool = Track(id: UUID().uuidString, name: "Old School", difficulty: .green, likes: 0,
                                 distance: nil, averageTime: nil, videoURL: URL(string: SecureKeys.oldSchoolVideoURL))
    static let moria = Track(id: UUID().uuidString, name: "Moria", difficulty: .blue, likes: 0,
                             distance: nil, averageTime: nil)
    static let blaize = Track(id: UUID().uuidString, name: "Blaize", difficulty: .red, likes: 0,
                              distance: nil, averageTime: nil, videoURL: URL(string: SecureKeys.blaizeVideoURL))
    static let airCore = Track(id: UUID().uuidString, name: "Air Core", difficulty: .black, likes: 0,
                               distance: nil, averageTime: nil, videoURL: URL(string: SecureKeys.airCoreVideoURL))
    static let scred = Track(id: UUID().uuidString, name: "Scred", difficulty: .diamond, likes: 0,
                             distance: nil, averageTime: nil, videoURL: URL(string: SecureKeys.scredVideoURL))
    
    // Spot
    static let cornillon = Spot(id: "CornillonID", name: "DCF Cornillon",
                                tracks: [slake, oldSchool, moria, blaize, airCore, scred],
                                members: 159, peoplePresent: [])
}
