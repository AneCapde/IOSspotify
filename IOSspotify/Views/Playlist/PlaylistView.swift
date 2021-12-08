//
//  PlaylistView.swift
//  music_player_app
//
//  Created by Michalina Janik on 07/11/2021.
//
import SwiftUI

struct PlaylistView: View {
    
    @EnvironmentObject var model: ModelMusicPlayer
    
    var body: some View {
        NavigationView{
            ScrollView{
                LazyVGrid(columns: [GridItem(.flexible(), spacing: 20),GridItem(.flexible(), spacing: 20)], spacing: 20){
                    ForEach(model.playlists, id: \.self) { song in
                        PlaylistCardView(playlist: song)
                    }
                }
                .padding(.horizontal, 20)
            }
            .navigationBarTitle(Text("Playlists"), displayMode: .automatic)
        }
    }
}

struct PlaylistView_Previews: PreviewProvider {
    static var previews: some View {
        PlaylistView()
    }
}
