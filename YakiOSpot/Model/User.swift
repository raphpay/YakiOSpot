//
//  User.swift
//  YakiOSpot
//
//  Created by Raphaël Payet on 12/11/2021.
//

import Foundation

/**
The user documentation
 
 # Parameters :
    - `id: A unique identifier. Set when creating a user`
    - `pseudo: The pseudo of the user. Set when creating a user.`
    - `mail: The email of the user. Set when creating a user.`
*/

struct User: Codable {
    var id: String = ""
    var pseudo: String = ""
    var mail: String = ""
    var favoritedSpotsIDs: [String]?
}
