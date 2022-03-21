//
//  YakiViewViewModel.swift
//  YakiOSpot
//
//  Created by Raphaël Payet on 03/01/2022.
//

import Foundation

final class YakiViewViewModel: ObservableObject {
    @Published var peoplePresent: [User] = []
    @Published var sessions: [Session] = []
    
    init() {
        fetchData()
    }
}


// MARK: - Initialisation
extension YakiViewViewModel {
    func fetchData() {
        API.Spot.session.getPeoplePresent { peoplePresent in
            self.peoplePresent = peoplePresent
        } onError: { error in
            print("======= \(#function) getPeoplePresent =====", error)
        }
        API.Session.session.removeOldSessionsIfNeeded { remainingSessions, sessionsRemoved in
            self.sessions = remainingSessions
            
        } onError: { error in
            print("======= \(#function) =====", error)
        }

    }
}
