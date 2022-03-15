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
    func setUserPresence(onSuccess: @escaping ((_ user: User) -> Void), onError: @escaping((_ error: String) -> Void))
    func setUserAbsence(onSuccess: @escaping ((_ user: User) -> Void), onError: @escaping((_ error: String) -> Void))
    func addSessionToUser(sessionID: String, to user: User, onSuccess: @escaping ((_ newUser: User) -> Void), onError: @escaping((_ error: String) -> Void))
    func getUserFromUID(_ uid: String, onSuccess: @escaping ((_ user: User) -> Void), onError: @escaping (( _ error: String) -> Void))
    func updateCurrentUser(_ updatedUser: User, onSuccess: @escaping (() -> Void), onError: @escaping((_ error: String) -> Void))
    func updateLocalCurrentUser(id: String, onSuccess: @escaping (() -> Void), onError: @escaping((_ error: String) -> Void))
    func removeUsersPresence(_ outdatedUsers: [User], onError: @escaping((_ error: String) -> Void))
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
    
    func addSessionToUser(sessionID: String, to user: User, onSuccess: @escaping ((_ newUser: User) -> Void), onError: @escaping ((String) -> Void)) {
        let specificUserRef = USERS_REF.document(user.id)
        var artificialUser = user
        
        if artificialUser.sessions == nil {
            artificialUser.sessions = [sessionID]
        } else {
            artificialUser.sessions?.append(sessionID)
        }
        
        do {
            try specificUserRef.setData(from: artificialUser)
            onSuccess(artificialUser)
        } catch let error {
            onError(error.localizedDescription)
        }
    }

    func setUserPresence(onSuccess: @escaping ((_ user: User) -> Void), onError: @escaping((_ error: String) -> Void)) {
        guard var user = API.User.CURRENT_USER_OBJECT else { return }
        user.isPresent = true
        user.presenceDate = Date.now
        do {
            try USERS_REF.document(user.id).setData(from: user, merge: true)
            API.User.CURRENT_USER_OBJECT = user
            onSuccess(user)
        } catch let error {
            onError(error.localizedDescription)
        }
    }
    
    func setUserAbsence(onSuccess: @escaping ((_ user: User) -> Void), onError: @escaping((_ error: String) -> Void)) {
        guard var user = API.User.CURRENT_USER_OBJECT else { return }
        user.isPresent = false
        user.presenceDate = nil
        do {
            try USERS_REF.document(user.id).setData(from: user, merge: true)
            USERS_REF.document(user.id).updateData(["presenceDate": FieldValue.delete()])
            API.User.CURRENT_USER_OBJECT = user
            onSuccess(user)
        } catch let error {
            onError(error.localizedDescription)
        }
    }
}


// MARK: - Fetch
extension UserService {    
    func getUserFromUID(_ uid: String, onSuccess: @escaping ((User) -> Void), onError: @escaping (( _ error: String) -> Void)) {
        USERS_REF.document(uid).getDocument { snapshot, error in
            guard error == nil else {
                onError("No user")
                return
            }
            guard let snapshot = snapshot else {
                onError("No user")
                return
            }
            
            do {
                if let user = try snapshot.data(as: User.self) {
                    onSuccess(user)
                }
            } catch let error {
                onError("Error getting user from uid \(uid). Error: \(error.localizedDescription)")
            }
            
        }
    }
}

// MARK: - Update
extension UserService {
    func updateCurrentUser(_ updatedUser: User, onSuccess: @escaping (() -> Void), onError: @escaping((_ error: String) -> Void)) {
        // Update current user
        API.User.CURRENT_USER_OBJECT = updatedUser
        
        let specificUserRef = USERS_REF.document(updatedUser.id)
        
        do {
            try specificUserRef.setData(from: updatedUser, merge: true)
            onSuccess()
        } catch let error {
            onError(error.localizedDescription)
        }
    }
    
    func updateLocalCurrentUser(id: String, onSuccess: @escaping (() -> Void), onError: @escaping((_ error: String) -> Void)) {
        USERS_REF.document(id).getDocument { snapshot, error in
            guard error == nil else {
                onError(error!.localizedDescription)
                return
            }
            guard let snapshot = snapshot else {
                onError("No snapshot")
                return
            }
            
            do {
                API.User.CURRENT_USER_OBJECT = try snapshot.data(as: User.self)
                onSuccess()
            } catch let error {
                onError(error.localizedDescription)
            }
        }
    }
}


// MARK: - Remove
extension UserService {
    func removeUsersPresence(_ outdatedUsers: [User], onError: @escaping((_ error: String) -> Void)) {
        for user in outdatedUsers {
            var artificialUser = user
            let dic : [String: Any] = ["presenceDate": FieldValue.delete()]
            artificialUser.isPresent = false
            do {
                try USERS_REF.document(artificialUser.id).setData(from: artificialUser, merge: true)
                USERS_REF.document(user.id).updateData(dic) { error in
                    guard error == nil else {
                        onError(error!.localizedDescription)
                        return
                    }
                }
            } catch let error {
                onError(error.localizedDescription)
            }
        }
    }
}
