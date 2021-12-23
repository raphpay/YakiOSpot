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
*/

struct User: Codable, Hashable {
    var id: String = ""
    var pseudo: String = ""
    var mail: String = ""
    var favoritedSpotsIDs: [String]?
    var isPresent: Bool? = false
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
