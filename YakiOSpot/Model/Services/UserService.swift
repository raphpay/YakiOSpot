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
    func toggleUserPresence(_ user: User, onSuccess: @escaping ((_ isPresent: Bool) -> Void), onError: @escaping((_ error: String) -> Void))
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
    lazy var USERS_REF  = database.collection("users")
    lazy var SPOT_REF  = database.collection("spot")
    lazy var cornillonRef = SPOT_REF.document(DummySpot.cornillon.id)
}


// MARK: - Post
extension UserService {
    func addUserToDatabase(_ user: User, onSuccess: @escaping (() -> Void), onError: @escaping((_ error: String) -> Void)) {
        let specificUserRef = USERS_REF.document(user.id)
        
        do {
            try specificUserRef.setData(from: user)
            UserDefaults.standard.set("pseudo", forKey: user.pseudo)
        } catch let error {
            onError(error.localizedDescription)
        }
        
        onSuccess()
    }
    
    func toggleUserPresence(_ user: User, onSuccess: @escaping ((_ isPresent: Bool) -> Void), onError: @escaping((_ error: String) -> Void)) {
        let specificUserRef = USERS_REF.document(user.id)
        var artificialUser = user
        let userIsPresentValue = UserDefaults.standard.bool(forKey: DefaultKeys.IS_USER_PRESENT)
        if userIsPresentValue == true {
            artificialUser.isPresent = false
            UserDefaults.standard.set(false, forKey: DefaultKeys.IS_USER_PRESENT)
        } else {
            artificialUser.isPresent = true
            UserDefaults.standard.set(true, forKey: DefaultKeys.IS_USER_PRESENT)
        }
        
        do {
            try specificUserRef.setData(from: artificialUser, merge: true)
            onSuccess(artificialUser.isPresent!)
        } catch let error {
            onError(error.localizedDescription)
        }
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
