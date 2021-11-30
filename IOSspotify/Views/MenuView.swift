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
        
    var body: some View {
        ScrollView{
            ScrollView(.horizontal, showsIndicators: false, content: {
                LazyHStack {
                    ForEach(self.data.albums, id:\.self, content: {
                        album in
                        AlbumArt(album: album, isWithText: true).onTapGesture{
                            self.currentAlbum = album
                        }
                    })
                }
            })
        
        LazyVStack {
            ForEach((self.currentAlbum?.songs ?? self.data.albums.first?.songs) ?? [Song(id: 0, name: "song1", time: "2:36")] , id:\.self, content: {
                song in SongCell(album: currentAlbum ?? data.albums.first!, song: song)
            })
        }
    }
    }
}

struct AlbumArt: View {
    var album : Album
    var isWithText : Bool
    var body: some View {
        ZStack(alignment: .bottom, content: {
            Image(album.image)
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
    var body: some View {
        NavigationLink(
            destination: PlayingView(album: album, song: song), label: {
            HStack{
                ZStack{
                    Circle()
                        .frame(width: 50, height: 50, alignment: .center)
                        .foregroundColor(.blue)
                    Circle()
                        .frame(width: 20, height: 20, alignment: .center)
                        .foregroundColor(.white)
                    
                }
                Text(song.name).bold()
                Spacer()
                Text(song.time)
            }.padding(20)
        }).buttonStyle(PlainButtonStyle())
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView(data: Data())
    }
}
