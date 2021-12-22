//
//  FeedView.swift
//  YakiOSpot
//
//  Created by Raphaël Payet on 10/12/2021.
//

import SwiftUI

struct FeedView: View {

    @ObservedObject var appState: AppState
    
    var body: some View {
        NavigationView {
            Text("Plus de fonctionnalités bientôt ! Restez connectés !")
                .multilineTextAlignment(.center)
                .lineLimit(2)
                .padding()
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
