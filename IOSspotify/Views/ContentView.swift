
//  Home.swift
//  music_player_app
//
//  Created by Michalina Janik on 07/11/2021.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var model = ModelMusicPlayer.singletonMusicPlayer
    var body: some View {
        TabView {
            PlaylistView().environmentObject(model)
                .tabItem{
                VStack {
                    Image(systemName: "music.note.list")
                    Text("Playlists")
                }
            }
            LibraryView().environmentObject(model)
                .tabItem{
                VStack{
                    Image(systemName: "music.note")
                    Text("Library")
                    
                }
            }
            
        }
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
       ContentView()
    }
}
