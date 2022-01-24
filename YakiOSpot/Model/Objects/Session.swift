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
    - `creator: The person that created the session. Set when creating a session. This should be an user object.`
    - `date: The starting date of the session. Set when creating a session by the user creator.`
    - `userIDs: The IDs of the users that will be present to the session.`
*/

struct Session: Codable, Hashable {
    var id: String = ""
    var creator: User
    var date: Date
    var userIDs: [String]?
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
