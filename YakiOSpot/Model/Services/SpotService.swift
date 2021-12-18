//
//  SpotService.swift
//  YakiOSpot
//
//  Created by Raphaël Payet on 15/11/2021.
//

import Foundation
import FirebaseFirestore

protocol SpotEngine {
    func getAllSpots(onSuccess: @escaping ((_ spots: [Spot]) -> Void), onError: @escaping((_ error: String) -> Void))
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
    lazy var SPOTS_REF = database.collection("spots")
}


// MARK: - Post
extension SpotService {
    // TODO: To be done when a screen to add a spot has been made
}


// MARK: - Fetch
extension SpotService {
    func getAllSpots(onSuccess: @escaping ((_ spots: [Spot]) -> Void), onError: @escaping((_ error: String) -> Void)) {
        print("getAllSpots")
        SPOTS_REF.getDocuments { snapshot, error in
            print("getAllSpots 2")
            guard error == nil else {
                onError("No Spots found")
                return
            }
            
            guard let snapshot = snapshot else {
                onError("No spots found")
                return
            }
            
            var spots: [Spot] = []
            
            for doc in snapshot.documents {
                
                do {
                    if let spot = try doc.data(as: Spot.self) {
                        spots.append(spot)
                    }
                } catch let error {
                    onError(error.localizedDescription)
                }
            }
            
            onSuccess(spots)
        }
    }
}
