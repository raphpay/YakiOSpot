//
//  BikeCreationView.swift
//  YakiOSpot
//
//  Created by Raphaël Payet on 30/01/2022.
//

import SwiftUI

struct BikeCreationView: View {
    
    @State private var bikeModel: String = ""
    private let imageSize = CGFloat(110)
    
    var body: some View {
        VStack(spacing: 16) {
            
            Image(Assets.noBike)
                .resizable()
                .frame(width: imageSize, height: imageSize)
                .aspectRatio(contentMode: .fill)
                .mask(RoundedRectangle(cornerRadius: 10))
            
            Button {
                //
            } label: {
                Text("Ajouter une photo")
                    .font(.system(size: 17))
            }
            
            FormTextField(placeholder: "Modèle du vélo", text: $bikeModel) {
                // Push bike
            }

            
            Button {
                // Push bike
            } label: {
                RoundedButton(title: "Ajouter mon vélo")
            }

            
            Spacer()
        }
        .navigationTitle("Mon bike")
    }
}

struct BikeCreationView_Previews: PreviewProvider {
    static var previews: some View {
        BikeCreationView()
    }
}
