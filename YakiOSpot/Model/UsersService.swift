//
//  UsersService.swift
//  YakiOSpot
//
//  Created by Raphaël Payet on 12/11/2021.
//

import Foundation
import FirebaseFirestore

class UserService {
    // MARK: - Singleton
    static let shared = UserService()
    private init() {}
    
    // MARK: - Properties
    let database = Firestore.firestore()
    lazy var USERS_REF = database.collection("users")
    
    // MARK: - Post
    func addUserToDatabase(_ user: User, onSuccess: @escaping (() -> Void), onError: @escaping((_ error: String) -> Void)) {
        guard let id = user.id else {
            onError("User not created.")
            return
        }
        
        let specificUserRef = USERS_REF.document(id)
        
        let user: [String: Any] = [
            "uid" : id,
            "pseudo": user.pseudo,
            "mail": user.mail
        ]
        
        specificUserRef.setData(user)
        
        onSuccess()
    }
    
    // MARK: - Fetch
    func getUserPseudo(with id: String, onSuccess: @escaping ((_ pseudo: String) -> Void), onError: @escaping((_ error: String) -> Void)) {
        USERS_REF.document(id).getDocument { snapshot, error in
            guard error == nil else {
                onError(error!.localizedDescription)
                return
            }
            
            guard let snapshot = snapshot else {
                onError("User not found")
                return
            }
            
            guard let user = snapshot.data(),
                  let pseudo = user["pseudo"] as? String else {
                onError("User not found")
                return
            }
            
            onSuccess(pseudo)
        }
    }
}
