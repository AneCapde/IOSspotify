//
//  SwiftUIView.swift
//  IOSspotify
//
//  Created by Michalina Janik on 08/12/2021.
//

import SwiftUI
import MediaPlayer
import AVFoundation


//menu view

struct Contentview2: View {
    @ObservedObject var modelView = ModelMusicPlayer.singletonMusicPlayer
    var body: some View {
        TabView {
            VStack(.spacing: 0){
                PlaylistView()
                TabBarMenu()
            }
                .enviromentObject(modelView)
                .tabItem {
                    VStack {
                        Image(systemName: "music.note.list")
                        Text("Playlists")
                    }
                }
            LibraryView()
                .enviromentObject(modelView)
                .tabItem {
                    VStack {
                        Image(systemName: "music.note")
                        Text("Library")
                    }
                }
        }
    }
    
}

struct Contentview2_Previews: PreviewProvider {
    static var previews: some View {
        Contentview2()
    }
}
