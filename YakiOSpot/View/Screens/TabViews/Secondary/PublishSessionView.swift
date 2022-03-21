//
//  PublishSessionView.swift
//  YakiOSpot
//
//  Created by Raphaël Payet on 24/01/2022.
//

import SwiftUI

struct PublishSessionView: View {
    
    @Environment(\.dismiss) var dismiss
    @StateObject private var viewModel = PublishSessionViewViewModel()
    
    var body: some View {
        VStack() {
            HStack {
                Text("Date de la session")
                    .font(.headline)    
                    .foregroundColor(.secondary)
                Spacer()
            }
            HStack {
                DatePicker("Please enter a time", selection: $viewModel.sessionDate, in: Date.now...)
                            .labelsHidden()
                Spacer()
            }
            Spacer()
            Button {
                viewModel.publishSession()
            } label: {
                RoundedButton(title: "Publier la session", width: 250)
            }
        }
        .navigationTitle("Nouvelle session")
        .padding(.horizontal)
        .alert(viewModel.alertMessage, isPresented: $viewModel.showAlert) {
            Button(viewModel.sessionPublished ? "Cool !" : "Réessayer", role: .cancel) {
                if (viewModel.sessionPublished) {
                    dismiss()
                }
            }
        }
    }
}
