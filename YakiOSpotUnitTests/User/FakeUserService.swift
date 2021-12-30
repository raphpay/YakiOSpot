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
    
    func getUserFromUID(_ uid: String, onSuccess: @escaping ((_ user: User) -> Void)) {
        
    }
}
