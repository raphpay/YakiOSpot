//
//  YakiView.swift
//  YakiOSpot
//
//  Created by Raphaël Payet on 03/01/2022.
//

import SwiftUI

struct YakiView: View {
    var body: some View {
        NavigationView {
            Text("YakiView")
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
