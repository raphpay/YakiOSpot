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
    
    func addSessionToUser(sessionID: String, to user: User, onSuccess: @escaping ((User) -> Void), onError: @escaping ((String) -> Void)) {
        var artificialUser = user
        if artificialUser.sessions == nil {
            artificialUser.sessions = [sessionID]
        } else {
            artificialUser.sessions?.append(sessionID)
        }
        
        onSuccess(artificialUser)
    }
    
    func setUserPresence(onSuccess: @escaping ((User) -> Void), onError: @escaping ((String) -> Void)) {
        guard FakeUserData.mutableUser.id != "" else {
            onError(FakeUserData.incorrectUserError)
            return
        }
        
        FakeUserData.mutableUser.isPresent = true
        FakeUserData.mutableUser.presenceDate = FakeUserData.correctDate
        
        let user = FakeUserData.mutableUser
        
        onSuccess(user)
    }
    
    func setUserAbsence(onSuccess: @escaping ((User) -> Void), onError: @escaping ((String) -> Void)) {
        guard FakeUserData.mutableUser.id != "" else {
            onError(FakeUserData.incorrectUserError)
            return
        }
        
        FakeUserData.mutableUser.isPresent = false
        FakeUserData.mutableUser.presenceDate = nil
        
        let user = FakeUserData.mutableUser
        
        onSuccess(user)
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

// MARK: - Update
extension FakeUserService {
    func updateCurrentUser(_ updatedUser: User, onSuccess: @escaping (() -> Void), onError: @escaping ((String) -> Void)) {
        guard updatedUser.id != "" else {
            onError(FakeUserData.incorrectUserError)
            return
        }
        
        FakeUserData.mutableUser = updatedUser
        onSuccess()
    }
    
    func updateLocalCurrentUser(id: String, onSuccess: @escaping (() -> Void), onError: @escaping ((String) -> Void)) {
        // Same as the method above here in the tests
    }
}

// MARK: - Remove
extension FakeUserService {
    
    func removeUsersPresence(_ outdatedUsers: [User], onError: @escaping ((String) -> Void)) {
        for user in outdatedUsers {
            var artificialUser = user
            artificialUser.presenceDate = nil
            artificialUser.isPresent = false
            
            for savedUser in FakeUserData.mutableUsers {
                if savedUser.id == artificialUser.id,
                   let index = FakeUserData.mutableUsers.firstIndex(where: { $0.id == artificialUser.id }) {
                    FakeUserData.mutableUsers.remove(at: index)
                    FakeUserData.mutableUsers.insert(artificialUser, at: index)
                }
            }
        }
    }
}


// MARK: - To be placed
extension FakeUserService {
    
    func removeSessionsFromUsersIfNeeded(sessions: [Session], onError: @escaping ((String) -> Void)) {
        //
    }
}
