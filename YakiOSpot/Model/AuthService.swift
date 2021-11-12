//
//  AuthService.swift
//  YakiOSpot
//
//  Created by Raphaël Payet on 11/11/2021.
//
import Foundation
import FirebaseAuth

class AuthService {
    // MARK: - Singleton
    static let shared = AuthService()
    private init() {}
    
    // MARK: Registration
    func createUser(email: String, password: String,
                    onSuccess: @escaping ((_ userID: String) -> Void), onError: @escaping ((_ error: String) -> Void)) {
        Auth.auth().createUser(withEmail: email, password: password) { _result, _error in
            guard _error == nil else {
                let errorString = Helper.convertAuthErrorFromFirebase(_error!)
                onError(errorString)
                return
            }
            
            guard let result = _result else {
                onError(AuthError.userCreation.description)
                return
            }
            
            onSuccess(result.user.uid)
        }
    }
    
    // MARK: - Log in / out
    func signIn(email: String, password: String,
                onSuccess: @escaping ((_ userID : String) -> Void), onError: @escaping ((_ error: String) -> Void)) {
        Auth.auth().signIn(withEmail: email, password: password) { _result, _error in
            guard _error == nil else {
                let errorString = Helper.convertAuthErrorFromFirebase(_error!)
                onError(errorString)
                return
            }
            
            guard let result = _result else {
                onError(AuthError.signIn.description)
                return
            }
            
            let userID = result.user.uid
            onSuccess(userID)
        }
    }
    
    
    func signOut(onSuccess: @escaping (() -> Void), onError: @escaping ((_ error: String) -> Void)) {
        do {
            try Auth.auth().signOut()
            onSuccess()
        } catch {
            onError(AuthError.signOut.description)
        }
    }
}
