//
//  UsersService.swift
//  YakiOSpot
//
//  Created by Raphaël Payet on 12/11/2021.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth

protocol UserEngine {
    func addUserToDatabase(_ user: User, onSuccess: @escaping (() -> Void), onError: @escaping((_ error: String) -> Void))
    func getUserPseudo(with id: String, onSuccess: @escaping ((_ pseudo: String) -> Void), onError: @escaping((_ error: String) -> Void))
    func getUserFromUID(_ uid: String, onSuccess: @escaping ((_ user: User) -> Void))
}

final class UserEngineService {
    var session: UserEngine
    
    static let shared = UserEngineService()
    init(session: UserEngine = UserService.shared) {
        self.session = session
    }
    
    var CURRENT_USER: FirebaseAuth.User? {
        // We get the current logged in User from Firebase
        if let currentUser = Auth.auth().currentUser {
            return currentUser
        }
        return nil
    }
    
    var CURRENT_USER_OBJECT: User?
}

final class UserService: UserEngine {
    // MARK: - Singleton
    static let shared = UserService()
    private init() {}
    
    // MARK: - Properties
    let database = Firestore.firestore()
    lazy var USERS_REF = database.collection("users")
    lazy var SPOTS_REF = database.collection("spots")
}


// MARK: - Post
extension UserService {
    func addUserToDatabase(_ user: User, onSuccess: @escaping (() -> Void), onError: @escaping((_ error: String) -> Void)) {
        let specificUserRef = USERS_REF.document(user.id)
        
        do {
            try specificUserRef.setData(from: user)
        } catch let error {
            onError(error.localizedDescription)
        }
        
        onSuccess()
    }
}


// MARK: - Fetch
extension UserService {
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
            
            do {
                if let user = try snapshot.data(as: User.self) {
                    onSuccess(user.pseudo)
                }
            } catch let error {
                onError(error.localizedDescription)
            }
            
            guard let user = snapshot.data(),
                  let pseudo = user["pseudo"] as? String else {
                onError("User not found")
                return
            }
            
            onSuccess(pseudo)
        }
    }
    
    func getUserFromUID(_ uid: String, onSuccess: @escaping ((User) -> Void)) {
        USERS_REF.document(uid).getDocument { snapshot, error in
            guard error == nil else { return }
            guard let snapshot = snapshot else { return }
            
            do {
                if let user = try snapshot.data(as: User.self) {
                    onSuccess(user)
                }
            } catch let error {
                print("Error getting user from uid \(uid). Error: \(error.localizedDescription)")
            }
            
        }
    }
}
