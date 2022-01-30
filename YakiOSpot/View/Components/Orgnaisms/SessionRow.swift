//
//  SessionRow.swift
//  YakiOSpot
//
//  Created by Raphaël Payet on 30/01/2022.
//

import SwiftUI

struct SessionRow: View {
    
    @Binding var sessions: [Session]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(sessions, id: \.id) { session in
                    NavigationLink(destination: SessionView(viewModel: SessionViewViewModel(session: session))) {
                        SessionCard(session: session)
                    }
                }
            }
            .padding(.horizontal)
        }
    }
    
    var emptySessions: some View {
        HStack(alignment: .center, spacing: 8) {
            Image(Assets.noSession)
                .resizable()
                .frame(width: 126, height: 100)
            
            Text("Pas de sessions prévues")
                .font(.system(size: 16))
                .fontWeight(.medium)
        }
    }
}
