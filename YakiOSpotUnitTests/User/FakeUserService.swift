//
//  FakeUserService.swift
//  YakiOSpotUnitTests
//
//  Created by Raphaël Payet on 09/12/2021.
//

import Foundation
@testable import YakiOSpot

final class FakeUserService : UserEngine {
    static let shared = FakeUserService()
    private init() {}
}


// MARK: - Post
extension FakeUserService {
    func addUserToDatabase(_ user: User, onSuccess: @escaping (() -> Void), onError: @escaping ((String) -> Void)) {
        guard user.id != "" else {
            onError(FakeUserData.postError)
            return
        }

        // Add user to local database
        FakeUserData.mutableUsers.append(user)
        onSuccess()
    }
    
    func toggleUserPresence(_ user: User, onSuccess: @escaping ((_ isPresent: Bool) -> Void), onError: @escaping((_ error: String) -> Void)) {
        var artificialUser = user
        if let userIsPresent = artificialUser.isPresent,
            userIsPresent {
            artificialUser.isPresent = false
        } else {
            artificialUser.isPresent = true
        }
        
        onSuccess(artificialUser.isPresent!)
    }
    
    func addSessionToUser(sessionID: String, to user: User, onSuccess: @escaping ((User) -> Void), onError: @escaping ((String) -> Void)) {
        var artificialUser = user
        if artificialUser.sessions == nil {
            artificialUser.sessions = [sessionID]
        } else {
            artificialUser.sessions?.append(sessionID)
        }
        
        onSuccess(artificialUser)
    }
}


// MARK: - Fetch
extension FakeUserService {
    func getUserPseudo(with id: String, onSuccess: @escaping ((String) -> Void), onError: @escaping ((String) -> Void)) {
        guard FakeUserData.referenceUsers.contains(where: { $0.id == id}),
              let user = FakeUserData.referenceUsers.first(where: { $0.id == id}) else {
                  onError(FakeUserData.noUserError)
                  return
              }
        
        onSuccess(user.pseudo)
    }
    
    func getUserFromUID(_ uid: String, onSuccess: @escaping ((User) -> Void), onError: @escaping ((String) -> Void)) {
        if FakeUserData.referenceUsers.contains(where: { $0.id == uid }),
           let user = FakeUserData.referenceUsers.first(where: { $0.id == uid }) {
            onSuccess(user)
        } else {
            onError(FakeUserData.noUserError)
        }
    }
}


// MARK: - To be placed
extension FakeUserService {
    func setUserPresence(onSuccess: @escaping ((User) -> Void), onError: @escaping ((String) -> Void)) {
        //
    }
    
    func setUserAbsence(onSuccess: @escaping ((User) -> Void), onError: @escaping ((String) -> Void)) {
        //
    }
    
    func updateCurrentUser(_ updatedUser: User, onSuccess: @escaping (() -> Void), onError: @escaping ((String) -> Void)) {
        //
    }
    
    func updateLocalCurrentUser(id: String, onSuccess: @escaping (() -> Void), onError: @escaping ((String) -> Void)) {
        //
    }
    
    func removeUsersPresence(_ outdatedUsers: [User], onError: @escaping ((String) -> Void)) {
        //
    }
    
    func removeSessionsFromUsersIfNeeded(sessions: [Session], onError: @escaping ((String) -> Void)) {
        //
    }
}
