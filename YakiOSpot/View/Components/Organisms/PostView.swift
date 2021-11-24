//
//  PostView.swift
//  YakiOSpot
//
//  Created by Raphaël Payet on 24/11/2021.
//

import SwiftUI

struct PostView: View {
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image(systemName: "person.circle")
                Text("User Name")
                    .font(.title3)
                    .fontWeight(.bold)
                Text("- 6h")
                    .font(.callout)
                    .foregroundColor(.secondary)
            }
            
            Text("Yo tout le monde ! Qui sera présent pour une session demain dans l’après-midi ?")
                .fixedSize(horizontal: false, vertical: true)
                .padding(.vertical)
            
            HStack {
                Image(systemName: "bubble.left")
                Text("12")
                
                
                Image(systemName: "hand.thumbsup.fill")
                Text("12")
            }
        }
    }
}

struct PostView_Previews: PreviewProvider {
    static var previews: some View {
        PostView()
    }
}
