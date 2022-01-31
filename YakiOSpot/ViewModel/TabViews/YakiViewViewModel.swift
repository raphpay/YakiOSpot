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
            let updatedSession = API.Session.session.removeOldSessionsIfNeeded(sessions: sessions)
            self.sessions = updatedSession
        } onError: { error in
            print("fetchAllSession", error)
        }
    }
    
    func toggleUserPresence() {
        guard let user = API.User.CURRENT_USER_OBJECT else { return }
        API.User.session.toggleUserPresence(user) { isPresent in
            var newUser = user
            newUser.isPresent = isPresent
            API.Spot.session.getSpot { spot in
                API.Spot.session.toggleUserPresence(from: spot, user: newUser) {
                    // Send notifications to every one
                    if isPresent {
                        API.Token.session.getAllTokens { tokens in
                            for token in tokens {
                               PushNotificationSender.shared.sendPresenceNotification(to: token, from: newUser.pseudo)
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
