//
//  SessionService.swift
//  YakiOSpot
//
//  Created by Raphaël Payet on 24/01/2022.
//

import Foundation
import FirebaseFirestore

// TODO: To be tested
protocol SessionEngine {
    func postSession(date: Date, creator: User, onSuccess: @escaping ((_ sessionID: String) -> Void), onError: @escaping((_ error: String) -> Void))
    func setUserPresent(_ userID: String, session: Session, isPresent: Bool)
    func fetchAllSession(onSuccess: @escaping ((_ sessions: [Session]) -> Void), onError: @escaping((_ error: String) -> Void))
    func fetchUsers(for session: Session, onSuccess: @escaping ((_ users: [User]) -> Void), onError: @escaping((_ error: String) -> Void))
    func removeOldSessionsIfNeeded(sessions: [Session]) -> [Session] 
    func fetchSessionsForIDs(_ sessionIDs: [String], onSuccess: @escaping ((_ sessions: [Session]) -> Void), onError: @escaping((_ error: String) -> Void))
}

final class SessionEngineService {
    var session: SessionEngine
    
    static let shared = SessionEngineService()
    init(session: SessionEngine = SessionService.shared) {
        self.session = session
    }
}

final class SessionService: SessionEngine {
    // MARK: - Singleton
    static let shared = SessionService()
    private init() {}
    
    // MARK: - Properties
    let database            = Firestore.firestore()
    lazy var USERS_REF      = database.collection("users")
    lazy var SESSION_REF    = database.collection("session")
}


// MARK: - Post
extension SessionService {
    func postSession(date: Date, creator: User, onSuccess: @escaping ((_ sessionID: String) -> Void), onError: @escaping((_ error: String) -> Void)) {
        let id = UUID().uuidString
        let session = Session(id: id, creator: creator, date: date)
        let sessionRef = SESSION_REF.document(session.id)
        
        do {
            try sessionRef.setData(from: session)
            onSuccess(session.id)
        } catch let error {
            onError(error.localizedDescription)
        }
    }
    
    func setUserPresent(_ userID: String, session: Session, isPresent: Bool) {
        let sessionRef = SESSION_REF.document(session.id)
        
        var newSession = session
        if isPresent {
            if newSession.userIDs == nil {
                newSession.userIDs = [userID]
            } else {
                newSession.userIDs?.append(userID)
            }
        } else {
            if newSession.userIDs != nil,
               let targetIndex = newSession.userIDs?.firstIndex(where: { $0 == userID }) {
                newSession.userIDs?.remove(at: targetIndex)
            }
        }
        
        
        do {
            try sessionRef.setData(from: newSession)
        } catch let error {
            print(error.localizedDescription)
        }
    }
}


// MARK: - Fetch
extension SessionService {
    func fetchAllSession(onSuccess: @escaping ((_ sessions: [Session]) -> Void), onError: @escaping((_ error: String) -> Void)) {
        SESSION_REF.addSnapshotListener { snapshot, error in
            guard error == nil else {
                onError(error!.localizedDescription)
                return
            }
            
            guard let snapshot = snapshot else {
                onError("No available session")
                return
            }
            
            var sessions: [Session] = []
            for document in snapshot.documents {
                do {
                    if let session = try document.data(as: Session.self) {
                        sessions.append(session)
                    }
                } catch let catchedError {
                    onError(catchedError.localizedDescription)
                }
            }
            
            onSuccess(sessions)
        }
    }
    
    func fetchUsers(for session: Session, onSuccess: @escaping ((_ users: [User]) -> Void), onError: @escaping((_ error: String) -> Void)) {
        guard let userIDs = session.userIDs else {
            onError("No user present for this session")
            return
        }
        
        USERS_REF.getDocuments { snapshot, error in
            guard error == nil else {
                onError(error!.localizedDescription)
                return
            }
            
            guard let snapshot = snapshot else {
                onError("No user present for this session")
                return
            }
            
            var allUsers: [User] = []
            for id in userIDs {
                if snapshot.documents.contains(where: { $0.documentID == id}),
                   let document = snapshot.documents.first(where: { $0.documentID == id}) {
                    do {
                        if let user = try document.data(as: User.self) {
                            allUsers.append(user)
                        }
                    } catch let error {
                        onError(error.localizedDescription)
                    }
                }
            }
            
            onSuccess(allUsers)
        }
    }
    
    func fetchSessionsForIDs(_ sessionIDs: [String], onSuccess: @escaping ((_ sessions: [Session]) -> Void), onError: @escaping((_ error: String) -> Void)) {
        var sessions: [Session] = []
        var index = 0
        for sessionID in sessionIDs {
            SESSION_REF.whereField("id", isEqualTo: sessionID).getDocuments { snapshot, error in
                guard error == nil else {
                    onError(error!.localizedDescription)
                    return
                }
                
                guard let snapshot = snapshot else {
                    onError("No user present for this session")
                    return
                }
                
                do {
                    if let session = try snapshot.documents[0].data(as: Session.self) {
                        sessions.append(session)
                    }
                } catch let error {
                    onError(error.localizedDescription)
                }
                
                index += 1
                
                if index >= sessionIDs.count {
                    onSuccess(sessions)
                }
            }
        }
    }
}


// MARK: - Remove
extension SessionService {
    func removeOldSessionsIfNeeded(sessions: [Session]) -> [Session] {
        var remainingSessions: [Session] = sessions
        for sessionIndex in 0..<sessions.count {
            let session = remainingSessions[sessionIndex]
            
            if session.date < Date.now {
                remainingSessions.remove(at: sessionIndex)
                SESSION_REF.document(session.id).delete()
            }
        }
        
        return remainingSessions
    }
}
