//
//  UserModificationView.swift
//  YakiOSpot
//
//  Created by Raphaël Payet on 12/02/2022.
//

import SwiftUI

struct UserModificationView: View {
    
    @ObservedObject var profileState: ProfileState
    
    var body: some View {
        VStack {
            // Profile Image
            
            Text(profileState.user.mail)
            // Pseudo
            
            // Mail
            
            // Password
        }
        .onAppear {
            print("UserModif", profileState.user)
        }
    }
}
