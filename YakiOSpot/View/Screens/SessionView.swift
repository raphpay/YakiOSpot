//
//  SessionView.swift
//  YakiOSpot
//
//  Created by Raphaël Payet on 26/01/2022.
//

import SwiftUI

struct SessionView: View {
    
    @ObservedObject var viewModel: SessionViewViewModel
    
    var body: some View {
        VStack {
            List {
                Section {
                    Text(viewModel.session.date.formatted(date: .long, time: .shortened))
                } header: {
                    Text("Date de la session")
                }
                Section {
                    Text(viewModel.session.creator.pseudo)
                } header: {
                    Text("Organisée par :")
                }
                if !viewModel.users.isEmpty {
                    Section {
                        ForEach(viewModel.users, id: \.self) { person in
                            Text(person.pseudo)
                        }
                    } header: {
                        Text("Qui sera là ?")
                    }
                }
            }
            Button {
                viewModel.togglePresence()
            } label: {
                RoundedButton(title: viewModel.isUserPresent ? "Je ne serais pas là !" : "Je serais là !")
            }
        }
        .onAppear {
            viewModel.getPresentUsers()
            viewModel.getUserPresence()
        }
    }
}
