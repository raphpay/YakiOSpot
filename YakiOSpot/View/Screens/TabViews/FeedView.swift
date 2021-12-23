//
//  FeedView.swift
//  YakiOSpot
//
//  Created by Raphaël Payet on 10/12/2021.
//

import SwiftUI

struct FeedView: View {
    
    @ObservedObject var appState: AppState
    
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
            .onAppear {
                API.Spot.session.getPeoplePresent { users in
                    self.peoplePresent = users
                } onError: { error in
                    print(error)
                }

            }
            .navigationTitle("Yaki O Spot")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        //
                    }) {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.black)
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: Text("Profile")) {
                        Image(systemName: "person.circle")
                            .foregroundColor(Color(UIColor.label))
                    }
                }
            }
        }
    }
}

struct FeedView_Previews: PreviewProvider {
    static var previews: some View {
        FeedView(appState: AppState())
    }
}
