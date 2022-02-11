//
//  ProfileViewViewModel.swift
//  YakiOSpot
//
//  Created by Raphaël Payet on 29/01/2022.
//

import Foundation

final class ProfileState: ObservableObject {
    // User object
    @Published var user: User = MockUser.data
    @Published var bike: Bike = Bike(id: UUID().uuidString, model: "", photoURL: nil)
    // TODO: Download data
    @Published var bikeImageData = Data()
    
    // User properties
    @Published var userIsPresent: Bool = true
    @Published var userIsNotPresent: Bool = false
    @Published var sessions: [Session] = []
    
    // Alert
    @Published var showAlert: Bool = false
    @Published var alertTitle: String = ""
    @Published var agreeButtonText: String = ""
    @Published var cancelButtonText: String = ""
    @Published var buttonSelected: Int = 0
    
    // Navigation
    @Published var showSessionCreation: Bool = false
    @Published var showBikeCreation: Bool = false
    
    init() {
        fetchData()
    }
}

// MARK: - Initialisation
extension ProfileState {
    func fetchData() {
        guard let currentUser = API.User.CURRENT_USER_OBJECT else { return }
        API.User.session.getUserFromUID(currentUser.id) { user in
            self.user = user
            if let bike = user.bike {
                self.bike = bike
            }
            self.updatePresence(user.isPresent)
           self.updateSessions(user.sessions)
        } onError: { error in
            self.updatePresence(false)
        }
    }
}

// MARK: - Actions
extension ProfileState {
    func didTapHereButton() {
        if buttonSelected != 0 {
            showAlert.toggle()
            alertTitle = "Tu es au spot ?"
            agreeButtonText = "Oui, je suis là !"
            cancelButtonText = "Non, je ne suis pas là"
        }
    }
    
    func didTapLeavingButton() {
        if buttonSelected != 1 {
            showAlert.toggle()
            alertTitle = "Tu pars déjà ?"
            agreeButtonText = "Oui, je pars !"
            cancelButtonText = "Je suis toujours là"
        }
    }
    
    func toggleUserPresence() {
        guard var user = API.User.CURRENT_USER_OBJECT else { return }
        API.User.session.toggleUserPresence(user) { isPresent in
            // Update local properties
            self.updatePresence(isPresent)
            // Toggle user object presence
            user.isPresent = isPresent
            API.Spot.session.getSpot { spot in
                API.Spot.session.toggleUserPresence(from: spot, user: user) {
                    // Send notifications to every one
                    if isPresent {
                        API.Token.session.getAllTokens { tokens in
                            for token in tokens {
//                               PushNotificationSender.shared.sendPresenceNotification(to: token, from: user.pseudo)
                            }
                        } onError: { error in
                            print("getAllTokens error", error)
                        }
                    }
                } onError: { error in
                    print("toggleUserPresence error")
                }
            } onError: { error in
                print("getSpot", error)
            }
        } onError: { error in
            // Show alert
            print("getSpot toggleUserPresence error")
        }
    }
}

// MARK: - Private Method
extension ProfileState {
    private func updatePresence(_ presence: Bool?) {
        if let presence = presence,
           presence == true {
            self.userIsPresent = true
            self.userIsNotPresent = false
            buttonSelected = 0
        } else {
            self.userIsPresent = false
            self.userIsNotPresent = true
            buttonSelected = 1
        }
    }
    
    private func updateSessions(_ array: [String]?) {
        if let sessionIDs = array,
           !sessionIDs.isEmpty {
            API.Session.session.fetchSessionsForIDs(sessionIDs) { sessions in
                self.sessions = sessions
            } onError: { error in
                self.sessions = []
            }

        } else {
            sessions = []
        }
    }
}
