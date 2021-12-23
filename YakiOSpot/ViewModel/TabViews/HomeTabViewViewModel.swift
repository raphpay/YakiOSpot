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
        API.User.session.toggleUserPresence(user) {
            API.Spot.session.getSpot { spot in
                API.Spot.session.toggleUserPresence(from: spot, user: user) {
                    print("toggleUserPresence success")
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
