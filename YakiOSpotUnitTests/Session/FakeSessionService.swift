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
    func postSession(date: Date, creator: User, sessionID: String, onSuccess: @escaping (() -> Void), onError: @escaping ((String) -> Void)) {
        guard sessionID != "" else {
            onError(FakeSessionData.incorrectIDError)
            return
        }
        let newSession = Session(id: sessionID, creator: creator, date: date)
        FakeSessionData.mutableSessions.append(newSession)
        onSuccess()
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
    
    func fetchSessionsForIDs(_ sessionIDs: [String], onSuccess: @escaping (([Session]) -> Void), onError: @escaping ((String) -> Void)) {
        // Get all sessions
        let allSessions = FakeSessionData.mutableSessions
        var foundSessions: [Session] = []
        
        // Filter all sessions that contains a certain ID
        for sessionID in sessionIDs {
            if allSessions.contains(where: { $0.id == sessionID }),
               let sessionFound = allSessions.first(where: { $0.id == sessionID }) {
                foundSessions.append(sessionFound)
            }
        }
        
        if foundSessions.isEmpty {
            onError(FakeSessionData.noSessionError)
        } else {
            onSuccess(foundSessions)
        }
    }
}

// MARK: - Remove
extension FakeSessionService {
    func removeOldSessionsIfNeeded(onSuccess: @escaping (([Session], [Session]) -> Void), onError: @escaping ((String) -> Void)) {
        // Get all sessions
        var remainingSessions = FakeSessionData.mutableSessions
        var sessionsRemoved: [Session] = []
        
        // Check if session is outdated
        for session in FakeSessionData.mutableSessions {
            if self.isSessionOutdated(sessionDate: session.date),
               let index = FakeSessionData.mutableSessions.firstIndex(where: { $0.id == session.id }) {
                remainingSessions.remove(at: index)
                sessionsRemoved.append(session)
                FakeSessionData.mutableSessions.remove(at: index)
            }
        }
        
        onSuccess(remainingSessions, sessionsRemoved)
    }
    
    private func isSessionOutdated(sessionDate: Date) -> Bool {
        if let dayAfter = Calendar.current.date(byAdding: .day, value: 1, to: sessionDate) {
            if dayAfter < Date.now {
                return true
            }
        }
        
        return false
    }
}
