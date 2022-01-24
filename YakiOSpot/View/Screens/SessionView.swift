//
//  SessionView.swift
//  YakiOSpot
//
//  Created by Raphaël Payet on 24/01/2022.
//

import SwiftUI

struct SessionView: View {
    
    @State private var sessionDate = Date.now
    
    var body: some View {
        VStack() {
            HStack {
                Text("Date de la session")
                    .font(.headline)
                    .foregroundColor(.secondary)
                Spacer()
            }
            HStack {
                DatePicker("Please enter a time", selection: $sessionDate, in: Date.now...)
                            .labelsHidden()
                Spacer()
            }
            Spacer()
            Button {
                //
            } label: {
                RoundedButton(title: "Publier la session", width: 250)
            }

        }
        .navigationTitle("Nouvelle session")
        .padding(.horizontal)
    }
}

struct SessionView_Previews: PreviewProvider {
    static var previews: some View {
        SessionView()
    }
}
