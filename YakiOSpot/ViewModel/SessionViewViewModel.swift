//
//  SessionViewViewModel.swift
//  YakiOSpot
//
//  Created by Raphaël Payet on 26/01/2022.
//

import Foundation

final class SessionViewViewModel: ObservableObject {
    // MARK: - Properties
    @Published var session = MockSession.mockSession
    @Published var users: [User] = []
    @Published var isUserPresent: Bool = false
    @Published var showAlert: Bool = false
    @Published var alertTitle: String = ""
    @Published var alertMessage: String = ""
    @Published var isCurrentUserCreator: Bool = false
    
    
    // MARK: - Init
    init(session: Session) {
        self.session = session
    }
    
    
    // MARK: - Methods
    func setupViewModel() {
        getPresentUsers()
        getUserPresence()
        getCurrentUser()
    }
    
    
    // MARK: - Actions
    func togglePresence() {
        self.isUserPresent.toggle()
        guard let currentUser = API.User.CURRENT_USER_OBJECT else { return }
        API.Session.session.setUserPresent(currentUser.id, session: session, isPresent: isUserPresent)
    }
    
    
    // MARK: - Private Methods
    private func getPresentUsers() {
        API.Session.session.fetchUsers(for: session) { users in
            self.users = users
        } onError: { error in
            print(error)
        }
    }
    
    private  func getUserPresence() {
        guard let currentUser = API.User.CURRENT_USER_OBJECT else { return }
        if let userIDs = session.userIDs,
           userIDs.contains(where: { $0 == currentUser.id}) {
            self.isUserPresent = true
        } else {
            self.isUserPresent = false
        }
    }
    
    private func getCurrentUser() {
        guard let currentUser = API.User.CURRENT_USER_OBJECT else { return }
        if session.creator.id == currentUser.id {
            isCurrentUserCreator = true
        } else {
            isCurrentUserCreator = false
        }
    }
}
