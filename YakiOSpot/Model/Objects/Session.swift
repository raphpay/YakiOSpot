//
//  Session.swift
//  YakiOSpot
//
//  Created by Raphaël Payet on 24/01/2022.
//

import Foundation

/**
The user documentation
 
 # Parameters :
         - `id: A unique identifier. Set when creating a session`
    - `date: The starting date of the session. Set when creating a session by the user creator.`
    - `userIDs: The IDs of the users that will be present to the session.`
*/

struct Session: Codable, Hashable {
    var id: String = ""
    var date: Date
    var userIDs: [String]
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
