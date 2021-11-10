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
            List{
                ForEach(model.playlists, id: \.self) { playlist in
                    PlaylistCardView(playlist: playlist)
                }
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
