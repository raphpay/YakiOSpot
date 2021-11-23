//
//  FakeAuthService.swift
//  YakiOSpotUnitTests
//
//  Created by Raphaël Payet on 23/11/2021.
//

import Foundation
@testable import YakiOSpot

final class FakeAuthService : AuthEngine {
    static let shared = FakeAuthService()
    private init() {}
}


// MARK: - Registration
extension FakeAuthService {
    func createUser(email: String, password: String, onSuccess: @escaping ((String) -> Void), onError: @escaping ((String) -> Void)) {
        // Verify email
        guard self.verifyEmail(email) == nil else {
            onError(self.verifyEmail(email)!)
            return
        }
        
        guard FakeAuthData.mutableUsers.contains(where: { $0.mail != email }) else {
            // A user is already signed in with the current mail
            onError(FakeAuthData.alreadySignedInError)
            return
        }
        
        // Verify password
        guard self.verifyPassword(password) == nil else {
            onError(self.verifyPassword(password)!)
            return
        }
        
        // Create a user
        let newID = UUID().uuidString
        let user = User(id: newID, pseudo: FakeAuthData.correctPseudo2, mail: email, favoritedSpotsIDs: nil)
        
        FakeAuthData.mutableUsers.append(user)
        onSuccess(newID)
    }
    
//    func createUser(email: String, password: String,
//                    onSuccess: @escaping ((_ userID: String) -> Void), onError: @escaping ((_ error: String) -> Void)) {
//        Auth.auth().createUser(withEmail: email, password: password) { _result, _error in
//            guard _error == nil else {
//                let errorString = Helper.convertAuthErrorFromFirebase(_error!)
//                onError(errorString)
//                return
//            }
//
//            guard let result = _result else {
//                onError(AuthError.userCreation.description)
//                return
//            }
//
//            onSuccess(result.user.uid)
//        }
//    }
}


// MARK: - Log in / out
extension FakeAuthService {
    func signIn(email: String, password: String, onSuccess: @escaping ((String) -> Void), onError: @escaping ((String) -> Void)) {
        //
    }
    
    func signOut(onSuccess: @escaping (() -> Void), onError: @escaping ((String) -> Void)) {
        //
    }
}


// MARK: - Private methods
extension FakeAuthService {
    private func verifyEmail(_ email: String) -> String? {
        guard !email.isEmpty else {
            return FakeAuthData.emptyMailError
        }
        
        guard email.isValidEmail() else {
            return FakeAuthData.invalidMailError
        }
        
        return nil
    }
    
    private func verifyPassword(_ password: String) -> String? {
        guard !password.isEmpty else {
            return FakeAuthData.emptyPasswordError
        }
        
        guard password.count >= 6 else {
            return FakeAuthData.invalidPasswordError
        }
        
        return nil
    }
}
