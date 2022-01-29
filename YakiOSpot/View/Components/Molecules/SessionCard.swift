//
//  SessionCard.swift
//  YakiOSpot
//
//  Created by Raphaël Payet on 29/01/2022.
//

import SwiftUI

struct SessionCard: View {
    
    // TODO: Types to be changed
    let date: String
    let creatorName: String
    let numberOfPeople: Int
    
    init(date: String = "12 Fev 2022", creatorName: String = "raphpay", numberOfPeople: Int = 12) {
        self.date           = date
        self.creatorName    = creatorName
        self.numberOfPeople = numberOfPeople
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
                    Text(date)
                        .fontWeight(.bold)
                }
                HStack {
                    Text("Créée par:")
                        .foregroundColor(.secondary)
                    Text(creatorName)
                        .fontWeight(.bold)
                }
                HStack {
                    Text("\(numberOfPeople) personnes présentes")
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

struct SessionCard_Previews: PreviewProvider {
    static var previews: some View {
        SessionCard()
    }
}
