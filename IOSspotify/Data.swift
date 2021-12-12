//
//  Data.swift
//  IOSspotifyAne
//
//  Created by Ane Capdevila on 29/11/2021.
//

import Foundation

class Data: ObservableObject {
    
    @Published public var songs: [Song] = [Song(id: 0, name: "We Rock", time: "2:36", file: "song2"),
                                           Song(id: 1, name: "This is Me", time: "3:36", file: "song1"),
                                           Song(id: 2, name: "This is Our Song", time: "1:36", file: "song2"),
                                           Song(id: 3, name: "You are my favourite song", time: "2:26", file: "song1"),
                                           Song(id: 4, name: "Hasta la vista", time: "3:30", file: "song2"),
                                           Song(id: 5, name: "Fireworks", time: "2:36", file: "song2"),
                                           Song(id: 6, name: "You and Me", time: "2:36", file: "song2"),
                                           Song(id: 7, name: "song1", time: "2:36", file: "song2"),
                                           Song(id: 8, name: "Last Friday Night", time:"2:36", file: "song2"),
                                           Song(id: 9, name: "song2", time: "2:36", file: "song2")]
    
    
    @Published public var albums: [Album] = [Album(id: 0, name: "Camp Rock 1 & 2 Songs", image: "cover_1",
                                 songs: [Song(id: 0, name: "We Rock", time: "2:36", file: "song2"),
                                         Song(id: 1, name: "This is Me", time: "3:36", file: "song1"),
                                         Song(id: 2, name: "This is Our Song", time: "1:36", file: "song2"),
                                         Song(id: 3, name: "You are my favourite song", time: "2:26", file: "song1"),
                                         Song(id: 4, name: "Hasta la vista", time: "3:30", file: "song2")]),
                           Album(id: 1, name: "Katy Perry", image: "cover_2",
                                    songs: [Song(id: 5, name: "Fireworks", time: "2:36", file: "song2"),
                                            Song(id: 6, name: "You and Me", time: "2:36", file: "song2"),
                                            Song(id: 7, name: "song1", time: "2:36", file: "song2"),
                                            Song(id: 8, name: "Last Friday Night", time:"2:36", file: "song2"),
                                            Song(id: 9, name: "song2", time: "2:36", file: "song2")])]
        
    func getAllSongsfromAlbum(albumName: String) -> [Song] {
        albums.first {  album  in
            album.name == albumName
            
        }?.songs ?? []
    }
    
    func getSong(songName: String) -> Song?{
        let song =
            songs.first{ song in
            song.name == songName
        }
        return song ?? nil
    }
    
    
    func getAlbum(songName: String) -> Album?{
         let album = albums.first{
            $0.songs.contains(getSong(songName: songName)!)
        }
        return album!
    }
    
    func getAlbumImageName(songName: String) -> String{
        return getAlbum(songName: songName)!.image
    }
    
    
    
    
    
   
    
    
  
    
}
