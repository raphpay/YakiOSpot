//
//  FakeAuthData.swift
//  YakiOSpotUnitTests
//
//  Created by Raphaël Payet on 23/11/2021.
//

import Foundation
@testable import YakiOSpot

struct FakeFirebaseUser {
    var mail: String
    var password: String
    var uid: String?
}


final class FakeAuthData {
    // MARK: - Id
    static let correctID = "correctID"
    static let correctID2 = "correctID"
    
    
    // MARK: - Pseudo
    static let correctPseudo = "correctPseudo"
    static let correctPseudo2 = "correctPseudo2"
    
    
    // MARK: - Email
    static let correctEmail = "correctEmail@test.com"
    static let correctEmail2 = "correctEmail2@test.com"
    static let emptyMail        = ""
    static let incorrectEmail = "incorrectMail"
    static let notRegisteredEmail   = "notRegistered@test.com"
    
    
    // MARK: - Password
    static let correctPassword = "password12345"
    static let correctPassword2 = "password123452"
    static let emptyPassword = ""
    static let incorrectPassword = "pass"
    
    
    // MARK: - User
    static let correctUser = User(id: correctID, pseudo: correctPseudo, mail: correctEmail, favoritedSpotsIDs: nil)
    static let notRegisteredUser = FakeFirebaseUser(mail: notRegisteredEmail, password: correctPassword, uid: correctID)
    
    
    // MARK: - Users
    static let referenceUsers   = [correctUser]
    static var mutableUsers     = referenceUsers
    
    
    // MARK: - Error
    static let emptyMailError       = "emptyMailError"
    static let invalidMailError     = "invalidMailError"
    static let emptyPasswordError   = "emptyPasswordError"
    static let invalidPasswordError = "invalidPasswordError"
    static let alreadySignedInError = "alreadySignedInError"
}
