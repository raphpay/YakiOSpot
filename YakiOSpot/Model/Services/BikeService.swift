//
//  BikeService.swift
//  YakiOSpot
//
//  Created by Raphaël Payet on 30/01/2022.
//

import Foundation
import FirebaseFirestore

protocol BikeEngine {
    func pushBike(_ bike: Bike, onSuccess: @escaping (() -> Void), onError: @escaping((_ error: String) -> Void))
}

final class BikeEngineService {
    var session: BikeEngine
    
    static let shared = BikeEngineService()
    init(session: BikeEngine = BikeService.shared) {
        self.session = session
    }
}

final class BikeService: BikeEngine {
    static let shared = BikeService()
    private init() {}
    
    // MARK: - Properties
    let database = Firestore.firestore()
    lazy var USERS_REF  = database.collection("users")
}


// MARK: - Post
extension BikeService {
    func pushBike(_ bike: Bike, onSuccess: @escaping (() -> Void), onError: @escaping((_ error: String) -> Void)) {
        guard var user = API.User.CURRENT_USER_OBJECT else {
            onError("No connected user")
            return
        }
        
        let specificUserRef = USERS_REF.document(user.id)
        user.bike = bike
        
        do {
            try specificUserRef.setData(from: user)
            UserDefaults.standard.set("pseudo", forKey: user.pseudo)
            onSuccess()
        } catch let error {
            onError(error.localizedDescription)
        }
    }
}
