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
    func toggleUserPresence(from spot: Spot, user: User, onSuccess: @escaping (() -> Void), onError: @escaping((_ error: String) -> Void))
    func getPeople(onSuccess: @escaping ((_ peoplePresent: [User]) -> Void), onError: @escaping((_ error: String) -> Void))
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
    func toggleUserPresence(from spot: Spot, user: User, onSuccess: @escaping (() -> Void), onError: @escaping((_ error: String) -> Void)) {
        var artificialSpot = spot
        if var peoplePresent = artificialSpot.peoplePresent {
            // People present array exists
            if peoplePresent.contains(where: { $0.id == user.id}),
               user.isPresent == false, // The user has just toggle is presence to false
               let index = peoplePresent.firstIndex(where: { $0.id == user.id}) {
                // People present array contains the user
                // We have to remove him from the array
                peoplePresent.remove(at: index)
            } else if !peoplePresent.contains(where: { $0.id == user.id}),
                      user.isPresent == true {
                // People present array doesn't contain the user
                // We have to append him to the array
                peoplePresent.append(user)
            }
            artificialSpot.peoplePresent = peoplePresent
        } else {
            // People present array doesn't exist
            artificialSpot.peoplePresent = [user]
        }
        
        do {
            try cornillonRef.setData(from: artificialSpot)
            onSuccess()
        } catch let error {
            onError(error.localizedDescription)
        }
    }
    
    // TODO: To be done when a screen to add a spot has been made
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
    
    func getPeople(onSuccess: @escaping ((_ peoplePresent: [User]) -> Void), onError: @escaping((_ error: String) -> Void)) {
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
