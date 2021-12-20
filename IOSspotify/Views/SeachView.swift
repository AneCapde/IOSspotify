//
//  SearchView.swift
//  IOSspotify
//
//  Created by Ane Capdevila on 02/12/2021.
//

import SwiftUI
import UIKit

struct SearchView: View {
    
    @ObservedObject var data : Data
    @State var search = ""
    @State var currentDisplayArray: [Song]
    @ObservedObject var viewModel : ViewModelMusicPlayer
    @State var updateView: Bool
    
    
    var columns = Array(repeating: GridItem(.flexible(), spacing: 20), count:1)
    
    var body: some View {
        
        ScrollView{
            VStack(spacing: 18){
                
                HStack{
                    Text("Search")
                        .font(.largeTitle)
                        .fontWeight(.heavy)
                        .foregroundColor(.primary)
                    
                    Spacer(minLength: 0)
                    
                }
                
                HStack(spacing: 15){
                    
                    TextField("Search", text: $search,
                              onCommit: {self.searchSong()})
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.primary)
                        .onTapGesture {
                            self.searchSong()
                        }
                    
                }
                .padding(.vertical,10)
                .padding(.horizontal)
                .background(Color.primary.opacity(0.06))
                .cornerRadius(15)
                
                //Grid View of the Songs
                
                LazyVGrid(columns:columns , spacing:20){
                    ForEach(self.currentDisplayArray , id:\.self, content: {
                        song in SongCell(album: getAlbum(song: song), song: song, data: data, updateView: $updateView, viewModel: viewModel)
                    })
                }
                .padding(.top, 10)
            }
            .padding()
            .padding(.bottom, 80)
        }
    }
    
    private func getAlbum(song: Song) -> Album {
        
        
        
        for album in self.data.getAllAlbums(){
            
            if album.songs.contains(song){
                return album
            }
        }
        return Album()
    }
    private func searchSong(){
        var termporaryArray = [Song]()
        
        
        for album in self.data.getAllAlbums(){
            
            for song in album.songs{
                if (song.name!.contains(search)){
                    termporaryArray.append(song)
                }
                if (search == ""){
                    termporaryArray.append(song)
                }
            }
        }
        
        self.currentDisplayArray = termporaryArray
    }
}

//struct SearchView_Previews: PreviewProvider {
//    static var previews: some View {
//        SearchView(data: Data(), currentDisplayArray: [Song](), viewModel: ViewModelMusicPlayer())
//    }
//}
