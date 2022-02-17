//
//  BadgeIcon.swift
//  YakiOSpot
//
//  Created by Raphaël Payet on 17/02/2022.
//

import SwiftUI

struct BadgeIcon: View {
    
    @Binding var user: User
    var size = CGFloat(30)
    
    var badgeColor: Color {
        guard user.isMember == true else { return .red }
        switch user.memberType {
        case .rider:
            return .green
        case .ambassador:
            return .blue
        case .dev:
            return .black
        case .staff:
            return .brown
        default:
            return .red
        }
    }
    var isMember: Bool {
        guard let bool = user.isMember else { return false }
        return bool
    }
    
    var body: some View {
        ZStack {
            Circle()
                .foregroundColor(badgeColor)
            
            Image(systemName: isMember ? "checkmark" : "xmark")
                .resizable()
                .frame(width: size / 1.8, height: size / 1.8)
                .foregroundColor(.white)
        }
        .frame(width: size, height: size)
    }
}
