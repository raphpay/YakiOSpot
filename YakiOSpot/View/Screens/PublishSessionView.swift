//
//  PublishSessionView.swift
//  YakiOSpot
//
//  Created by Raphaël Payet on 24/01/2022.
//

import SwiftUI

struct PublishSessionView: View {
    
    @Environment(\.dismiss) var dismiss
    @State private var sessionDate = defaultSessionDate
    @State private var showAlert: Bool = false
    @State private var alertMessage: String = ""
    @State private var sessionPublished: Bool = false
    
    static var defaultSessionDate: Date {
        var components = DateComponents()
        let hourToAdd = 1
        components.hour = hourToAdd
        let futureDate = Calendar.current.date(byAdding: components, to: Date.now)
        return futureDate ?? Date.now
    }
    
    var body: some View {
        VStack() {
            HStack {
                Text("Date de la session")
                    .font(.headline)
                    .foregroundColor(.secondary)
                Spacer()
            }
            HStack {
                DatePicker("Please enter a time", selection: $sessionDate, in: Date.now...)
                            .labelsHidden()
                Spacer()
            }
            Spacer()
            Button {
                publishSession()
            } label: {
                RoundedButton(title: "Publier la session", width: 250)
            }
        }
        .navigationTitle("Nouvelle session")
        .padding(.horizontal)
        .alert(alertMessage, isPresented: $showAlert) {
            Button(sessionPublished ? "Cool !" : "Réessayer", role: .cancel) {
                if (sessionPublished) {
                    dismiss()
                }
            }
        }
    }
    
    func publishSession() {
        guard let creator = API.User.CURRENT_USER_OBJECT else { return }
        API.Session.session.postSession(date: sessionDate, creator: creator) { sessionID in
            API.User.session.addSessionToUser(sessionID: sessionID, to: creator) { newUser in
                // Show success alert
                showAlert(title: "Session publiée !", isPublished: true)
                // Update the current user
                API.User.CURRENT_USER_OBJECT = newUser
                // Go back to HomeTabView
            } onError: { error in
                // Show error alert
                showAlert(title: "Oups ! La session n'a pas été publiée !", isPublished: false)
            }
        } onError: { error in
            // Show error alert
            showAlert(title: "Oups ! La session n'a pas été publiée !", isPublished: false)
        }
    }
    
    func showAlert(title: String, isPublished: Bool) {
        alertMessage = title
        sessionPublished = isPublished
        showAlert.toggle()
    }
}
