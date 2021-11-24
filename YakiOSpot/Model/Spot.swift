//
//  Spot.swift
//  YakiOSpot
//
//  Created by Raphaël Payet on 14/11/2021.
//

import Foundation

// TODO: Update the documentation

/**
The spot documentation
 
 # Parameters :
    - `id: A unique identifier. Set when creating a user`
    - `pseudo: The pseudo of the user. Set when creating a user.`
    - `mail: The email of the user. Set when creating a user.`
*/

struct Spot: Codable, Hashable {
    var id: String?
    var name: String
    var tracks: [Track]
    var members: Int
    var peoplePresent: Int
    var favorites: Int?
    var isFavorited: Bool = false
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static let dummySpot = Spot(id: UUID().uuidString, name: "DCF Cornillon", tracks: Track.mockTracks, members: 172, peoplePresent: 18)
    
    static let mockMySpots = [
        Spot(id: UUID().uuidString, name: "DCF Cornillon", tracks: Track.mockTracks, members: 172, peoplePresent: 18),
        Spot(id: UUID().uuidString, name: "Evo Bike Park", tracks: Track.mockTracks, members: 235, peoplePresent: 53),
    ]
    
    static let mockTopSpots = [
        Spot(id: UUID().uuidString, name: "DCF Cornillon", tracks: Track.mockTracks, members: 172, peoplePresent: 18),
        Spot(id: UUID().uuidString, name: "Evo Bike Park", tracks: Track.mockTracks, members: 235, peoplePresent: 53),
        Spot(id: UUID().uuidString, name: "Chatel Bike Park", tracks: Track.mockTracks, members: 547, peoplePresent: 123),
    ]
}
