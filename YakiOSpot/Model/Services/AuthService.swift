//
//  AuthService.swift
//  YakiOSpot
//
//  Created by Raphaël Payet on 11/11/2021.
//
import Foundation
import FirebaseAuth

protocol AuthEngine {
    func createUser(email: String, password: String,
                    onSuccess: @escaping ((_ userID: String) -> Void), onError: @escaping ((_ error: String) -> Void))
    
    func sendResetPasswordMail(to email: String, onSuccess: @escaping (() -> Void), onError: @escaping ((_ error: String) -> Void))
    
    func signIn(email: String, password: String,
                onSuccess: @escaping ((_ userID : String) -> Void), onError: @escaping ((_ error: String) -> Void))
    
    func signOut(onSuccess: @escaping (() -> Void), onError: @escaping ((_ error: String) -> Void))
}

final class AuthEngineService {
    var session: AuthEngine
    
    static let shared = AuthEngineService()
    init(session: AuthEngine = AuthService.shared) {
        self.session = session
    }
}

final class AuthService: AuthEngine {
    // MARK: - Singleton
    static let shared = AuthService()
    private init() {}
}


// MARK: Registration
extension AuthService {
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
}


// MARK: - Password
extension AuthService {
    func sendResetPasswordMail(to email: String, onSuccess: @escaping (() -> Void), onError: @escaping ((_ error: String) -> Void)) {
        Auth.auth().sendPasswordReset(withEmail: email) { _error in
            guard _error == nil else {
                onError(_error!.localizedDescription)
                return
            }
            
            onSuccess()
        }
    }
}

// MARK: - Log in / out
extension AuthService {
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
