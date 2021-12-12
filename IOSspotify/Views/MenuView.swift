//
//  MenuView.swift
//  IOSspotifyAne
//
//  Created by Ane Capdevila on 17/11/2021.
//
import SwiftUI

struct MenuView: View {
    
    @State private var currentAlbum : Album?
    @ObservedObject var data : Data
    @ObservedObject var viewModel : ViewModelMusicPlayer
    var body: some View {
        ScrollView{
            ScrollView(.horizontal, showsIndicators: false, content: {
                LazyHStack {
                    ForEach(Data.albums, id:\.self, content: {
                        album in
                        AlbumArt(album: album, isWithText: true).onTapGesture{
                            self.currentAlbum = album
                        }
                    })
                }
            })
        
        LazyVStack {
            ForEach((self.currentAlbum?.songs ?? Data.albums.first?.songs)! , id:\.self, content: {
                song in SongCell(album: currentAlbum ?? Data.albums.first!, song: song, viewModel: viewModel)
            })
        }
    }
       // TabBarMenu()
    }
}

struct AlbumArt: View {
    var album : Album
    var isWithText : Bool
    var body: some View {
        ZStack(alignment: .bottom, content: {
            Image(uiImage: album.image)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 150, height: 200, alignment: .center)
            if isWithText == true {
                ZStack{
                    Blur(style: .dark)
                    Text(album.name).foregroundColor(.white)
                }.frame(height: 60, alignment: .center)
            }
            }).frame(width: 170, height: 200, alignment: .center)
            .clipped().cornerRadius(20).shadow(radius: 10).padding(20)
    }
}

struct SongCell: View {
    var album : Album
    var song : Song
    @ObservedObject var viewModel : ViewModelMusicPlayer
    @Namespace var animation
    
    var body: some View {
    
        
           
            HStack{
              
                Image(uiImage: album.image)
                    .resizable()
                    .aspectRatio(contentMode:   .fill)
                    .frame(width: 55, height: 55, alignment: .center)
                    .aspectRatio(contentMode:   .fill)
                    .cornerRadius(15)
                
           
                
                Text(song.name).bold()
                Spacer()
                Text(song.time)
            }
            .padding(20)
            .onTapGesture {
                
                
                viewModel.updateCurrentAlbum(album: album)
                viewModel.updateCurrentSong(song: song)
                viewModel.playSong()
                   // MiniPlayer(animation: Namespace.ID, expand: false, viewModel: viewModel)
                
            }
          
        }
}


struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView(data: Data(), viewModel: ViewModelMusicPlayer())
    }
}
