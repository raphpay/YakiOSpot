//
//  TrackView.swift
//  YakiOSpot
//
//  Created by Raphaël Payet on 18/12/2021.
//

import SwiftUI

struct TrackView: View {
    var track: Track
    
    var body: some View {
        VStack {
            ZStack() {
                Image(Assets.DCF)
                    .resizable()
                    .frame(height: 190)
                    .aspectRatio(contentMode: .fit)
                    .overlay(alignment: .bottom) {
                        Rectangle()
                            .frame(height: 140)
                            .foregroundColor(.black.opacity(0.85))
                    }
                HStack {
                    VStack {
                        Text(track.name)
                            .font(.title2)
                            .bold()
                            .foregroundColor(.white)
                        HStack {
                            Text("Difficulté: \(track.difficulty.description)")
                                .font(.body)
                                .foregroundColor(.white)
                            Image(systemName: "flag.fill")
                                .foregroundColor(track.difficulty.color)
                        }.padding(.horizontal)
                    }.frame(height: 140)
                    
                    Spacer()
                }
            }
            
            NavigationLink(destination: Text("Hello toi")) {
                HStack {
                    Text("Voir qui est présent ?")
                        .foregroundColor(.blue)
                    Spacer()
                    Image(systemName: "chevron.right")
                        .foregroundColor(.secondary)
                }
                .padding()
            }
            
            VStack(alignment: .leading) {
                Text("Vidéo")
                    .font(.body)
                    .foregroundColor(.secondary)
                    .padding(.horizontal)
                Rectangle()
                    .frame(height: 190)
                    .foregroundColor(.black.opacity(0.95))
            }
            
            Spacer()
        }.navigationBarTitle("Détails", displayMode: .inline)
    }
}
