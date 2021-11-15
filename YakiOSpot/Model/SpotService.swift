//
//  SpotService.swift
//  YakiOSpot
//
//  Created by Raphaël Payet on 15/11/2021.
//

import Foundation
import FirebaseFirestore

class SpotService {
    // MARK: - Singleton
    static let shared = SpotService()
    private init() {}
    
    // MARK: - Properties
    let database = Firestore.firestore()
    lazy var SPOTS_REF = database.collection("spots")
    
    // MARK: - Post
    // TODO: To be done when a screen to add a spot has been made
    
    // MARK: - Fetch
//    func getUserPseudo(with id: String, onSuccess: @escaping ((_ pseudo: String) -> Void), onError: @escaping((_ error: String) -> Void)) {
//        USERS_REF.document(id).getDocument { snapshot, error in
//            guard error == nil else {
//                onError(error!.localizedDescription)
//                return
//            }
//
//            guard let snapshot = snapshot else {
//                onError("User not found")
//                return
//            }
//
//            guard let user = snapshot.data(),
//                  let pseudo = user["pseudo"] as? String else {
//                onError("User not found")
//                return
//            }
//
//            onSuccess(pseudo)
//        }
//    }
    
    
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
                let data = doc.data()
                
                if let tracks = data["tracks"] as? Int,
                    let peoplePresent = data["peoplePresent"] as? Int,
                   let members = data["members"] as? Int,
                   let name = data["name"] as? String,
                   let id = data["id"] as? String {
                    let spot = Spot(id: id, name: name, tracks: tracks, members: members, peoplePresent: peoplePresent)
                    spots.append(spot)
                }
            }
            
            onSuccess(spots)
        }
    }
}
