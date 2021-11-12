//
//  SpotListView.swift
//  YakiOSpot
//
//  Created by Raphaël Payet on 11/11/2021.
//

import SwiftUI

struct SpotListView: View {
    @Binding var isConnected: Bool
    
    @State var showAlert: Bool = false
    @State var alertMessage: String = ""
    
    var body: some View {
        VStack {
            Text("Spot List")
            Button {
                didTapLogOut()
            } label: {
                Text("Log Out")
                    .foregroundColor(.red)
            }
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Oups"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
        }
    }
    
    func didTapLogOut() {
        API.Auth.signOut {
            isConnected = false
        } onError: { error in
            alertMessage = error
            showAlert.toggle()
        }

    }
}

struct SpotListView_Previews: PreviewProvider {
    static var previews: some View {
        SpotListView(isConnected: .constant(true))
    }
}
