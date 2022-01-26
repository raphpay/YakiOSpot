//
//  SessionViewViewModel.swift
//  YakiOSpot
//
//  Created by Raphaël Payet on 26/01/2022.
//

import Foundation

final class SessionViewViewModel: ObservableObject {
    @Published var session = MockSession.mockSession
    @Published var users: [User] = []
    @Published var isUserPresent: Bool = false
    @Published var showAlert: Bool = false
    @Published var alertTitle: String = ""
    @Published var alertMessage: String = ""
    
    init(session: Session) {
        self.session = session
    }
    
    func togglePresence() {
        self.isUserPresent.toggle()
        guard let currentUser = API.User.CURRENT_USER_OBJECT else { return }
        API.Session.session.setUserPresent(currentUser.id, session: session, isPresent: isUserPresent) {
            print("setUserPresent success")
        } onError: { error in
            print("setUserPresent error")
        }
    }
    
    func getPresentUsers() {
        API.Session.session.fetchUsers(for: session) { users in
            self.users = users
        } onError: { error in
            print(error)
        }
    }
    
    func getUserPresence() {
        guard let currentUser = API.User.CURRENT_USER_OBJECT else { return }
        if let userIDs = session.userIDs,
           userIDs.contains(where: { $0 == currentUser.id}) {
            self.isUserPresent = true
        } else {
            self.isUserPresent = false
        }
    }
}
