//
//  ProfileRow.swift
//  YakiOSpot
//
//  Created by Raphaël Payet on 30/01/2022.
//

import SwiftUI
import SDWebImageSwiftUI

struct UserRow: View {
    
    @ObservedObject var profileState: ProfileState
    
    private let imageSize = CGFloat(85)
    
    var userMembershipType: String {
        guard let memberType = profileState.user.memberType,
              profileState.user.isMember == true else { return "Non adhérent" }
        return memberType.description
    }
    
    var body: some View {
        HStack(alignment: .center, spacing: 28) {
            profileImage
            
            VStack(alignment: .leading, spacing: 8) {
                Text(profileState.user.pseudo)
                    .font(.title)
                    .fontWeight(.bold)
                
                Text(userMembershipType)
                    .font(.headline)
                    .foregroundColor(.secondary)
            }
            
            Spacer()

            NavigationLink(destination: UserModificationView(profileState: profileState)) {
                Image(systemName: "highlighter")
                    .font(.system(size: 25))
                    .foregroundColor(.secondary)
            }
        }
        .frame(maxWidth: .infinity, alignment: .center)
        .padding(.horizontal)
    }
    
    var profileImage: some View {
        ZStack {
            if let photoURL = profileState.user.photoURL {
                WebImage(url: URL(string: photoURL))
                    .resizable()
                    .placeholder(Image(Assets.imagePlaceholder))
                    .frame(width: imageSize, height: imageSize)
                    .aspectRatio(contentMode: .fill)
                    .mask(Circle())
            } else {
                Image(Assets.imagePlaceholder)
                    .resizable()
                    .frame(width: imageSize, height: imageSize)
                    .aspectRatio(contentMode: .fill)
                    .mask(Circle())
            }
        }
        .overlay(BadgeIcon(user: $profileState.user, size: 25), alignment: .topTrailing)
    }
}
