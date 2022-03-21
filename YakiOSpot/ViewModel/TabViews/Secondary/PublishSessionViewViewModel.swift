//
//  PublishSessionViewViewModel.swift
//  YakiOSpot
//
//  Created by Raphaël Payet on 21/03/2022.
//

import Foundation

final class PublishSessionViewViewModel: ObservableObject {
    @Published var sessionDate = defaultSessionDate
    @Published var showAlert: Bool = false
    @Published var alertMessage: String = ""
    @Published var sessionPublished: Bool = false
    
    static var defaultSessionDate: Date {
        var components = DateComponents()
        let hourToAdd = 1
        components.hour = hourToAdd
        let futureDate = Calendar.current.date(byAdding: components, to: Date.now)
        return futureDate ?? Date.now
    }
}


extension PublishSessionViewViewModel {
    func publishSession() {
        guard let creator = API.User.CURRENT_USER_OBJECT else { return }
        let sessionID = UUID().uuidString
        API.User.session.addSessionToUser(sessionID: sessionID, to: creator) { newUser in
            API.Session.session.postSession(date: self.sessionDate, creator: newUser, sessionID: sessionID) {
                self.showAlert(title: "Session publiée !", isPublished: true)
            } onError: { error in
                self.showAlert(title: "Oups ! La session n'a pas été publiée !", isPublished: false)
            }
        } onError: { error in
            self.showAlert(title: "Oups ! La session n'a pas été publiée !", isPublished: false)
        }
    }
    
    func showAlert(title: String, isPublished: Bool) {
        alertMessage = title
        sessionPublished = isPublished
        showAlert.toggle()
    }
}
