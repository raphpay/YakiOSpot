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
}
