//
//  HomeTabViewViewModel.swift
//  YakiOSpot
//
//  Created by Raphaël Payet on 20/12/2021.
//

import Foundation

final class HomeTabViewViewModel: ObservableObject {
    let icons = ["info.circle", "hand.raised.fill", "bicycle"]
    let titles = ["Info", "", "Feed"]
    
    @Published var showAlert: Bool = false
    
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
