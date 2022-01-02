//
//  TrackView.swift
//  YakiOSpot
//
//  Created by Raphaël Payet on 18/12/2021.
//

import SwiftUI

struct TrackView: View {
    @ObservedObject var viewModel: TrackViewViewModel
    
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
                        Text(viewModel.track.name)
                            .font(.title2)
                            .bold()
                            .foregroundColor(.white)
                        HStack {
                            Text("Difficulté: \(viewModel.track.difficulty.description)")
                                .font(.body)
                                .foregroundColor(.white)
                            Image(systemName: "flag.fill")
                                .foregroundColor(viewModel.track.difficulty.color)
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
                viewModel.player
            }
            
            Spacer()
        }.navigationBarTitle("Détails", displayMode: .inline)
            .onDisappear {
                viewModel.stop()
            }
    }
}
