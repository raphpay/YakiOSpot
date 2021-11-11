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
    func createUser(email: String, password: String, onSuccess: @escaping ((String) -> Void), onError: @escaping ((String) -> Void)) {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            guard error == nil else {
                onError("Erreur: \(error!.localizedDescription)")
                return
            }
            
            guard let result = result else {
                onError("Pas de résultats")
                return
            }
            
            onSuccess(result.user.uid)
        }
    }
    
    // MARK: - Log in / out
    func signIn(email: String, password: String,
                onSuccess: @escaping ((_ userID : String) -> Void), onError: @escaping ((_ error: String) -> Void)) {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            guard error == nil else {
                onError("Erreur: \(error!.localizedDescription)")
                return
            }
            
            guard let result = result else {
                onError("Pas de résultat")
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
            onError("Error")
        }
    }
}
