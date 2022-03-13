//
//  SpotService.swift
//  YakiOSpot
//
//  Created by Raphaël Payet on 15/11/2021.
//

import Foundation
import FirebaseFirestore

protocol SpotEngine {
    func getSpot(onSuccess: @escaping ((_ spot: Spot) -> Void), onError: @escaping((_ error: String) -> Void))
    func setUserPresent(onSuccess: @escaping (() -> Void), onError: @escaping((_ error: String) -> Void))
    func getPeoplePresent(onSuccess: @escaping ((_ peoplePresent: [User]) -> Void), onError: @escaping((_ error: String) -> Void))
    func removeUsersFromSpot(_ users: [User], onSuccess: @escaping (() -> Void), onError: @escaping((_ error: String) -> Void))
}

final class SpotEngineService {
    var session: SpotEngine
    
    static let shared = SpotEngineService()
    init(session: SpotEngine = SpotService.shared) {
        self.session = session
    }
}

final class SpotService: SpotEngine {
    // MARK: - Singleton
    static let shared = SpotService()
    private init() {}
    
    // MARK: - Properties
    let database = Firestore.firestore()
    lazy var SPOT_REF = database.collection("spot")
    lazy var USERS_REF = database.collection("users")
    lazy var cornillonRef = SPOT_REF.document(DummySpot.cornillon.id)
}


// MARK: - Post
extension SpotService {
    func setUserPresent(onSuccess: @escaping (() -> Void), onError: @escaping((_ error: String) -> Void)) {
        guard let user = API.User.CURRENT_USER_OBJECT else { return }
        // TODO: Make a computed property to get the spot, just like the user above
        self.getSpot { spot in
            var newPeopleArray: [User] = []
            var artificialSpot = spot
            if let peoplePresent = spot.peoplePresent {
                newPeopleArray = peoplePresent
                newPeopleArray.append(user)
            } else {
                newPeopleArray = [user]
            }
            artificialSpot.peoplePresent = newPeopleArray
            do {
                try self.cornillonRef.setData(from: artificialSpot, merge: true)
                onSuccess()
            } catch let error {
                onError(error.localizedDescription)
            }
        } onError: { error in
            onError(error)
        }
    }
}


// MARK: - Fetch
extension SpotService {
    func getSpot(onSuccess: @escaping ((_ spot: Spot) -> Void), onError: @escaping((_ error: String) -> Void)) {
        cornillonRef.getDocument { snapshot, error in
            guard error == nil else {
                onError(error!.localizedDescription)
                return
            }
            guard let snapshot = snapshot else {
                onError("No data")
                return
            }
            
            do {
                if let spot = try snapshot.data(as: Spot.self) {
                    onSuccess(spot)
                }
            } catch let error {
                onError(error.localizedDescription)
            }
        }
    }
    
    func getPeoplePresent(onSuccess: @escaping ((_ peoplePresent: [User]) -> Void), onError: @escaping((_ error: String) -> Void)) {
        cornillonRef.addSnapshotListener { snapshot, error in
            guard error == nil else {
                onError(error!.localizedDescription)
                return
            }
            
            guard let snapshot = snapshot else {
                onError("Unexpected error")
                return
            }
            
            do {
                if let spot = try snapshot.data(as: Spot.self),
                   let people = spot.peoplePresent {
                    onSuccess(people)
                }
            } catch let error {
                onError(error.localizedDescription)
            }
        }
    }
}


// MARK: - Remove
extension SpotService {
    func removeUsersFromSpot(_ outdatedUsers: [User], onSuccess: @escaping (() -> Void), onError: @escaping((_ error: String) -> Void)) {
        self.getSpot { spot in
            var artificialSpot = spot
            // ---
            // Could be refactored
            var newPeopleArray: [User] = []
            if let peoplePresent = spot.peoplePresent {
                newPeopleArray = peoplePresent
                
                for user in outdatedUsers {
                    if newPeopleArray.contains(where: { $0.id == user.id }),
                       let index = newPeopleArray.firstIndex(where: { $0.id == user.id }) {
                        newPeopleArray.remove(at: index)
                    }
                }
                // ---
                if peoplePresent != newPeopleArray {
                    artificialSpot.peoplePresent = newPeopleArray
                    
                    do {
                        try self.cornillonRef.setData(from: artificialSpot, merge: true)
                    } catch let error {
                        onError(error.localizedDescription)
                    }
                }
                // --- 
            }
            // ---
            onSuccess()
        } onError: { error in
            onError(error)
        }
    }
}
