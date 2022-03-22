//
//  FakeSessionData.swift
//  YakiOSpotUnitTests
//
//  Created by Raphaël Payet on 26/01/2022.
//

import Foundation
@testable import YakiOSpot

final class FakeSessionData {
    // MARK: - IDs
    static let correctID = "correctID"
    static let incorrectID = ""
    static let newCorrectID = "newCorrectID"
    
    // MARK: - Users
    static let creator = User(id: "userID", pseudo: "creator", mail: "creator@test.com", favoritedSpotsIDs: nil, isPresent: nil, sessions: nil)
    static let correctUser = User(id: "correctUserID", pseudo: "correctUser", mail: "correctUser@test.com", favoritedSpotsIDs: nil, isPresent: nil, sessions: nil)
    static let newCorrectUser = User(id: "newCorrectUserID", pseudo: "newCorrectUser", mail: "newCorrectUser@test.com", favoritedSpotsIDs: nil, isPresent: nil, sessions: nil)
    
    // MARK: - Session
    static let correctSession = Session(id: correctID, creator: creator, date: Date.now, userIDs: nil)
    static var mutableSession = correctSession
    static var newMutableSession = Session(id: correctID, creator: creator, date: Date.now, userIDs: [correctUser.id])
    
    // MARK: - Arrays
    static let referenceSessions = [correctSession]
    static var mutableSessions = referenceSessions
    static let users = [correctUser]
    // MARK: - Errors
    static let noSessionError = "noSessionError"
    static let noUserError = "noUserError"
    static let incorrectIDError = "incorrectIDError"
}
