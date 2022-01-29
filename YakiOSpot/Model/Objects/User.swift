//
//  User.swift
//  YakiOSpot
//
//  Created by Raphaël Payet on 12/11/2021.
//

import Foundation
import FirebaseFirestoreSwift

/**
The user documentation
 
 # Parameters :
        - `id: A unique identifier. Set when creating a user`
    - `pseudo: The pseudo of the user. Set when creating a user.`
    - `mail: The email of the user. Set when creating a user.`
    - `favoritedSpotIDs: The spot favorited by this user. Always nil for the moment.`
    - `isPresent: A boolean value indicating whether the user is at the spot or not.`
    - `sessions: An array of the future sessions posted by the user`
*/

struct User: Codable, Hashable {
    var id: String = ""
    var pseudo: String = ""
    var mail: String = ""
    var favoritedSpotsIDs: [String]?
    var isPresent: Bool? = false
    var sessions: [String]?
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

struct MockUser {
    static let data = User(id: "1", pseudo: "mockUser", mail: "mockuser@test.com",
                    favoritedSpotsIDs: nil, isPresent: false, sessions: nil)
}
