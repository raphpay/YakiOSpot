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
    
    func fetchData() {
        API.Spot.session.getPeoplePresent { peoplePresent in
            self.peoplePresent = peoplePresent
        } onError: { error in
            print("======= \(#function) error =====", error)
        }
        API.Session.session.fetchAllSession { sessions in
            self.sessions = sessions
        } onError: { error in
            print("fetchAllSession", error)
        }
    }
}
