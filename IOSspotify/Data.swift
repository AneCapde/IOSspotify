//
//  Data.swift
//  IOSspotifyAne
//
//  Created by Ane Capdevila on 29/11/2021.
//

import Foundation
import MediaPlayer

struct DataModel{
    var songs : [Song]
    var albums : [Album]
    
    
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
        for album in albums{
            let allAlbumSongs = getAllSongsfromAlbum(albumName: album.name)
            if (allAlbumSongs.contains(getSong(songName: songName)!)){
                return album
            }
        }
        return nil
    }
    
    func getAlbum(albumName: String) -> Album?{
        let album = albums.first{ album in
            album.name == albumName
       }
       return album ?? nil
        
    }
    

     func getAlbumImage(songName: String) -> UIImage{
        return getAlbum(songName: songName)!.image
    }
    
    
}

class Data: ObservableObject {
       
    private static func generateSongTable() -> [Song]{
        var songs: [Song] = []
        let fileManager = FileManager.default
        let enumerator:FileManager.DirectoryEnumerator = fileManager.enumerator(atPath: fileManager.currentDirectoryPath)!
       
        while let element = enumerator.nextObject() as? String {
            if element.hasSuffix("mp3") {
                songs.append(Song(fileName: element))
            }
        }
        return songs
    }
    
   

            
            
    static let songs: [Song] = generateSongTable()
    static let albums: [Album] = [Album(name: "Katy Perry", songs: songs)]
                                        //                                 songs:
    
//    static let songs: [Song] = [Song(id: 0, name: "We Rock", time: "2:36", file: "song2"),
//                                           Song(id: 1, name: "This is Me", time: "3:36", file: "song1"),
//                                           Song(id: 2, name: "This is Our Song", time: "1:36", file: "song2"),
//                                           Song(id: 3, name: "You are my favourite song", time: "2:26", file: "song1"),
//                                           Song(id: 4, name: "Hasta la vista", time: "3:30", file: "song2"),
//                                           Song(id: 5, name: "Fireworks", time: "2:36", file: "song2"),
//                                           Song(id: 6, name: "You and Me", time: "2:36", file: "song2"),
//                                           Song(id: 7, name: "song1", time: "2:36", file: "song2"),
//                                           Song(id: 8, name: "Last Friday Night", time:"2:36", file: "song2"),
//                                           Song(id: 9, name: "song2", time: "2:36", file: "song2")]
//
//
//
//    static let albums: [Album] = [Album(id: 0, name: "Camp Rock 1 & 2 Songs", image: "cover_1",
//                                 songs: [Song(id: 0, name: "We Rock", time: "2:36", file: "song2"),
//                                         Song(id: 1, name: "This is Me", time: "3:36", file: "song1"),
//                                         Song(id: 2, name: "This is Our Song", time: "1:36", file: "song2"),
//                                         Song(id: 3, name: "You are my favourite song", time: "2:26", file: "song1"),
//                                         Song(id: 4, name: "Hasta la vista", time: "3:30", file: "song2")]),
//                           Album(id: 1, name: "Katy Perry", image: "cover_2",
//                                    songs: [Song(id: 5, name: "Fireworks", time: "2:36", file: "song2"),
//                                            Song(id: 6, name: "You and Me", time: "2:36", file: "song2"),
//                                            Song(id: 7, name: "song1", time: "2:36", file: "song2"),
//                                            Song(id: 8, name: "Last Friday Night", time:"2:36", file: "song2"),
//                                            Song(id: 9, name: "song2", time: "2:36", file: "song2")])]
//
    
    
    
    @Published var dataModel = DataModel(songs: songs, albums: albums)

        
    func getAllSongsfromAlbum(albumName: String) -> [Song] {
        dataModel.getAllSongsfromAlbum(albumName: albumName)
        
    }
    
     func getAllSongs() -> [Song]{
        return Data.songs
    }
    
     func getAllAlbums() -> [Album]{
        return Data.albums
    }
    
    
     func getSong(songName: String) -> Song?{
        dataModel.getSong(songName: songName)
    }
    
    func getAlbum(albumName: String) -> Album?{
        dataModel.getAlbum(albumName: albumName)
    }
    
    func getAlbum(songName: String) -> Album?{
        dataModel.getAlbum(songName: songName)
    }
    
    func getAlbumImageName(songName: String) -> UIImage{
        dataModel.getAlbumImage(songName: songName)
    }
    

    
}
