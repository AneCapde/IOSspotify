//
//  LibraryView.swift
//  music_player_app
//
//  Created by Michalina Janik on 07/11/2021.
//
import SwiftUI

struct LibraryView: View {
    
    @EnvironmentObject var model: ModelMusicPlayer
    
    var body: some View {
        NavigationView{
            List{
                ForEach(model.librarySongs, id: \.self){ song in
                    SongCardView(song: song)
                }
            }
            .navigationBarTitle("All Songs", displayMode: .automatic)
        }
    }
}

struct LibraryView_Previews: PreviewProvider {
    static var previews: some View {
        LibraryView()
    }
}
