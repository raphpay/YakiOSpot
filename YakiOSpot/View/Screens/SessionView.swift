//
//  SessionView.swift
//  YakiOSpot
//
//  Created by Raphaël Payet on 26/01/2022.
//

import SwiftUI

struct SessionView: View {
    
    var session: Session
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
//                if session.userIDs?.isEmpty {
//                    Section {
//                        ForEach(session.userIDs!, id: \.self) { person in
//                            Text("nom")
//                        }
//                    } header: {
//                        Text("Qui sera là ?")
//                    }
//                }
            }
            Button {
                //
            } label: {
                RoundedButton(title: "Je serais là")
            }

        }
    }
}
