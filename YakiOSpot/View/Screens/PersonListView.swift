//
//  PersonListView.swift
//  Pods
//
//  Created by Raphaël Payet on 23/12/2021.
//

import SwiftUI

struct PersonListView: View {
    var people: [User]
    
    var body: some View {
        List {
            ForEach(people, id: \.self) { user in
                Text(user.pseudo)
            }
        }
    }
}
