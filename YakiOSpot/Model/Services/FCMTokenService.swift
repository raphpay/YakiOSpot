//
//  FCMTokenService.swift
//  YakiOSpot
//
//  Created by Raphaël Payet on 24/12/2021.
//

import Foundation
import FirebaseFirestore
import FirebaseMessaging

protocol FCMTokenEngine {
    func getAllTokens(onSuccess: @escaping ((_ tokens: [String]) -> Void), onError: @escaping((_ error: String) -> Void))
    func updateFirestorePushTokenIfNeeded()
}

final class FCMTokenEngineService {
    var session: FCMTokenEngine
    
    static let shared = FCMTokenEngineService()
    init(session: FCMTokenEngine = FCMTokenService.shared) {
        self.session = session
    }
}

class FCMTokenService: FCMTokenEngine {
    static let shared = FCMTokenService()
    
    // MARK: - Properties
    let database = Firestore.firestore()
    lazy var TOKENS_REF  = database.collection("tokens")
    lazy var USERS_REF  = database.collection("users")
}

extension FCMTokenService {
    func getAllTokens(onSuccess: @escaping (([String]) -> Void), onError: @escaping ((String) -> Void)) {
        TOKENS_REF.getDocuments { snapshot, error in
            guard error == nil else {
                onError(error!.localizedDescription)
                return
            }
            guard let snapshot = snapshot else {
                onError("No data")
                return
            }
            
            var tokens: [String] = []
            
            for doc in snapshot.documents {
                guard let token = doc.data()["fcmToken"] as? String else { return }
                tokens.append(token)
            }
            
            onSuccess(tokens)
        }
    }
    
    func updateFirestorePushTokenIfNeeded() {
        if let token = Messaging.messaging().fcmToken,
           let userID = API.User.CURRENT_USER?.uid {
            let tokenDict = ["fcmToken": token]
            USERS_REF.document(userID).setData(tokenDict, merge: true)
            TOKENS_REF.document(token).setData(tokenDict)
            NotificationCenter.default.post(name: Notification.Name("FCMToken"), object: nil, userInfo: tokenDict)
        }
    }
}
