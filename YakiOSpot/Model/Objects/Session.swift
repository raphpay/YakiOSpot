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

struct Session: Identifiable, Codable, Hashable {
    var id: String = ""
    var creator: User
    var date: Date
    var userIDs: [String]?
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}


struct MockSession {
    static var mockSession = Session(id: UUID().uuidString,
                                     creator: User(id: UUID().uuidString, pseudo: "Creator user", mail: "", favoritedSpotsIDs: nil, isPresent: nil, sessions: nil),
                                     date: Date().addingTimeInterval(1500), userIDs: nil)
    static var mockSessions = [
        mockSession,
        Session(id: UUID().uuidString,
                creator: User(id: UUID().uuidString, pseudo: "Creator", mail: "", favoritedSpotsIDs: nil, isPresent: nil, sessions: nil),
                date: Date().addingTimeInterval(15000), userIDs: nil)
    ]
}
