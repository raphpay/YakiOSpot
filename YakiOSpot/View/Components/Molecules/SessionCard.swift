//
//  SessionCard.swift
//  YakiOSpot
//
//  Created by Raphaël Payet on 29/01/2022.
//

import SwiftUI

struct SessionCard: View {
    
    let session: Session
    var peopleText: String {
        if let peopleIDs = session.userIDs {
            if peopleIDs.count == 0 || peopleIDs.count == 1 {
                return "\(peopleIDs.count) personne présente"
            } else {
                return "\(peopleIDs.count) personnes présentes"
            }
        } else {
            return "Personne pour le moment !"
        }
    }
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .foregroundColor(.white)
                .frame(minWidth: 244, minHeight: 135, alignment: .leading)
                .shadow(radius: 8)
            
            VStack(alignment: .leading, spacing: 16) {
                HStack {
                    Text("Session prévue le :")
                        .foregroundColor(.secondary)
                    Text(session.date.getRelativeDateFromNow())
                        .fontWeight(.bold)
                }
                HStack {
                    Text("Créée par :")
                        .foregroundColor(.secondary)
                    Text(session.creator.pseudo)
                        .fontWeight(.bold)
                }
                HStack {
                    Text(peopleText)
                        .fontWeight(.bold)
                }
            }
            .font(.headline)
            .padding(.horizontal)
        }
        .frame(minWidth: 244, maxHeight: 135, alignment: .leading)
        .padding()
    }
}
