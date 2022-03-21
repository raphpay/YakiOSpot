//
//  FakeSessionService.swift
//  YakiOSpotUnitTests
//
//  Created by Raphaël Payet on 26/01/2022.
//

import Foundation
@testable import YakiOSpot

final class FakeSessionService: SessionEngine {
    static let shared = FakeSessionService()
    private init() {}
}


// MARK: - Post
extension FakeSessionService {
    func postSession(date: Date, creator: User, onSuccess: @escaping ((_ sessionID: String) -> Void), onError: @escaping ((_ error: String) -> Void)) {
        let id = FakeSessionData.newCorrectID
        let newSession = Session(id: id, creator: creator, date: date)
        FakeSessionData.mutableSessions.append(newSession)
        onSuccess(id)
    }
    
    func setUserPresent(_ userID: String, session: Session, isPresent: Bool) {
        var newSession = session
        
        if isPresent {
            if newSession.userIDs == nil {
                newSession.userIDs = [userID]
            } else {
                newSession.userIDs?.append(userID)
            }
        } else {
            if newSession.userIDs != nil,
               let targetIndex = newSession.userIDs?.firstIndex(where: { $0 == userID }){
                newSession.userIDs?.remove(at: targetIndex)
            }
        }
        
        FakeSessionData.mutableSession = newSession
    }
}


// MARK: - Fetch
extension FakeSessionService {
    func fetchAllSession(onSuccess: @escaping ((_ sessions: [Session]) -> Void), onError: @escaping ((_ error: String) -> Void)) {
        if FakeSessionData.mutableSessions.isEmpty {
            onError(FakeSessionData.noSessionError)
        } else {
            onSuccess(FakeSessionData.mutableSessions)
        }
    }
    
    func fetchUsers(for session: Session, onSuccess: @escaping ((_ users: [User]) -> Void), onError: @escaping ((_ error: String) -> Void)) {
        guard session.userIDs != nil else {
            onError(FakeSessionData.noUserError)
            return
        }
        
        onSuccess(FakeSessionData.users)
    }
}


// MARK: - To be placed
extension FakeSessionService {
    func removeOldSessionsIfNeeded(sessions: [Session]) -> [Session] {
        return []
    }
    
    func fetchSessionsForIDs(_ sessionIDs: [String], onSuccess: @escaping (([Session]) -> Void), onError: @escaping ((String) -> Void)) {
        //
    }
}
