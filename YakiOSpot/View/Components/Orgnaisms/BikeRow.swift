//
//  BikeRow.swift
//  YakiOSpot
//
//  Created by Raphaël Payet on 29/01/2022.
//

import SwiftUI
import SDWebImage

struct BikeRow: View {
    
    @State private var bike: Bike?
    @State private var imageData: Data?
    
    var body: some View {
        emptyBikeRow
    }
    
    var emptyBikeRow: some View {
        HStack(alignment: .center, spacing: 8) {
            Image(Assets.noBike)
                .resizable()
                .frame(width: 101, height: 110)
            
            Text("Pas de vélo enregistré")
        }
    }
    
    var content: some View {
        HStack {
            if let imageData = imageData {
                Image(uiImage: UIImage(data: imageData)!)
                    .resizable()
                    .frame(width: 100, height: 100)
                    .aspectRatio(contentMode: .fill)
                    .mask(RoundedRectangle(cornerRadius: 20))
            } else {
                Image(Assets.noBike)
                    .resizable()
                    .frame(width: 100, height: 100)
                    .aspectRatio(contentMode: .fill)
                    .mask(RoundedRectangle(cornerRadius: 20))
            }
            
            Text("Scott Genius 920")
                .font(.title3)
            
            Spacer()
            Image(systemName: "highlighter")
                .font(.system(size: 25))
                .foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity, alignment: .center)
        .padding(.horizontal)
        .onAppear {
            fetchData()
        }
    }
    
    func fetchData() {
        getBikeFromUser()
    }
    
    func getBikeFromUser() {
        guard let user = API.User.CURRENT_USER_OBJECT else { return }
        API.Bike.session.getBike(from: user) { bike in
            self.bike = bike
            downloadBikeImage(for: user)
        } onError: { error in
            print("======= \(#function) =====", error)
            self.bike = nil
        }
    }
    
    func downloadBikeImage(for user: User) {
        StorageService.shared.getBikeImage(for: user) { data in
            self.imageData = data
        } onError: { error in
            print("======= \(#function) =====", error)
        }
    }
}
