//
//  FeedView.swift
//  YakiOSpot
//
//  Created by Raphaël Payet on 10/12/2021.
//

import SwiftUI

struct FeedView: View {
    
    @EnvironmentObject var appState: AppState
    
    @State var peoplePresent: [User] = []
    
    var body: some View {
        NavigationView {
            VStack {
                if peoplePresent.count != 0 {
                    NavigationLink(destination: PersonListView(people: peoplePresent)) {
                        if peoplePresent.count == 1 {
                            Text("Il y a \(peoplePresent.count) personne présente")
                        } else {
                            Text("Il y a \(peoplePresent.count) personnes présentes")
                        }
                    }
                }
                
                
                Text("Plus de fonctionnalités bientôt ! Restez connectés !")
                    .multilineTextAlignment(.center)
                    .lineLimit(2)
                    .padding()
            }
            .navigationTitle("Yaki O Spot")
//            TODO: To be put when a multiple spots are added
//            .toolbar {
//                ToolbarItem(placement: .navigationBarLeading) {
//                    Button(action: {
//                        //
//                    }) {
//                        Image(systemName: "magnifyingglass")
//                            .foregroundColor(.black)
//                    }
//                }
//            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: ProfileView()) {
                        Image(systemName: "person.circle")
                            .foregroundColor(Color(UIColor.label))
                    }
                }
            }
        }
    }
}
