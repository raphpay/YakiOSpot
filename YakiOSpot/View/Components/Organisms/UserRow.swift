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
                GeometryReader { geo in
                    Text(profileState.user.pseudo)
                        .font(.system(size: geo.size.height > geo.size.width ? geo.size.width * 0.3 : geo.size.height * 0.3))
                        .fontWeight(.bold)
                }
                
                Text(userMembershipType)
                    .font(.headline)
                    .foregroundColor(.secondary)
            }
            
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
                    .aspectRatio(contentMode: .fill)
                    .frame(width: imageSize, height: imageSize)
                    .mask(Circle())
            } else {
                Image(Assets.imagePlaceholder)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: imageSize, height: imageSize)
                    .mask(Circle())
            }
        }
        .overlay(BadgeIcon(user: $profileState.user, size: 25), alignment: .topTrailing)
    }
}
