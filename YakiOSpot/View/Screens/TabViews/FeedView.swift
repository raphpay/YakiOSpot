//
//  FeedView.swift
//  YakiOSpot
//
//  Created by Raphaël Payet on 10/12/2021.
//

import SwiftUI

struct FeedView: View {
    var body: some View {
        NavigationView {
            Text("Feed")
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
        FeedView()
    }
}
