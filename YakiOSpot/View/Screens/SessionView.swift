//
//  SessionView.swift
//  YakiOSpot
//
//  Created by Raphaël Payet on 26/01/2022.
//

import SwiftUI

struct SessionView: View {
    
    var session: Session
    var users: [User] = []
    
    var body: some View {
        VStack {
            List {
                Section {
                    Text(session.date.formatted(date: .long, time: .shortened))
                } header: {
                    Text("Date de la session")
                }
                Section {
                    Text(session.creator.pseudo)
                } header: {
                    Text("Organisée par :")
                }
                if !users.isEmpty {
                    Section {
                        ForEach(users, id: \.self) { person in
                            Text(person.pseudo)
                        }
                    } header: {
                        Text("Qui sera là ?")
                    }
                }
            }
            Button {
                // Set people here for the session
            } label: {
                RoundedButton(title: "Je serais là")
            }
        }
        .onAppear {
            // Get people present
        }
    }
}
