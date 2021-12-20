//
//  PlaylistDisplay.swift
//  IOSspotify
//
//  Created by Ane Capdevila on 13/12/2021.
//

import SwiftUI

struct PlaylistDisplay: View {
    var playlist: PlaylistModel
    //var song: Song
    @ObservedObject var data : Data
    @ObservedObject var viewModel : ViewModelMusicPlayer
    @State var updateView = false

    var body: some View {
        
        ScrollView{
            VStack{
                Text("Songs")
                    .font(.largeTitle)
                    .fontWeight(.heavy)
                    .foregroundColor(.primary)
                
                Spacer(minLength: 0)
                    VStack{
                        ForEach(playlist.songs, id:\.self, content: {
                            song in SongCell(album: data.getAlbum(songName: song.name!)!, song: song, data: data, updateView: $updateView, viewModel: viewModel)
                        })
                    }  //cONTEXT MENU
                
            } .navigationViewStyle(StackNavigationViewStyle.init())
            
            
        }
        
    }
    
   
}


