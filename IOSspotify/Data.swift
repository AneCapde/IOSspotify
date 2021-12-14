//
//  Data.swift
//  IOSspotifyAne
//
//  Created by Ane Capdevila on 29/11/2021.
//

import Foundation
import MediaPlayer
import StoreKit

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
            let allAlbumSongs = getAllSongsfromAlbum(albumName: album.name!)
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
       
    //private let songDecorator: SongDecorator
    //private let albumDecorator: AlbumDecorator
    
    var songs: [Song] = [Song]()
    var albums: [Album] = [Album]()
                                     
    let default_songs: [Song] = [Song(name: "We Rock", time: 156.0, fileName: "song1"),
                                        Song(name: "This is Me", time: 225.5, fileName: "song2")]
    
     let default_albums: [Album] = [Album(name: "Katy Perry", songs: [Song(name: "We Rock", time: 156.0, fileName: "song1"),
                                                                            Song(name: "This is Me", time: 225.5, fileName: "song2")])]
                                           
    @Published var dataModel : DataModel
    
    init(){
        dataModel = DataModel(songs: songs, albums: albums)
        let songDecorators = generateSongDecoratorTable()
        songs = generateSongs(songsDecorators: songDecorators) ?? default_songs
        albums = generateAlbums(albumDecorators: generateAlbumDecorators(songsDecorators: songDecorators)) ?? default_albums
    }
    

    private func generateSongDecoratorTable() -> [SongDecorator]{
        var songTable: [SongDecorator] = []
        SKCloudServiceController.requestAuthorization{ status in
            if status == .authorized{
                let songQuery = MPMediaQuery.songs()
                if let userSongs = songQuery.items {
                    let sortByPlayedDate = NSSortDescriptor(key: MPMediaItemPropertyLastPlayedDate, ascending: false)
                     songTable = NSArray(array: userSongs).sortedArray(using: [sortByPlayedDate]) as! [SongDecorator]
                   
                }
               
            }
             
        }
        return songTable
    }
    
    private func generateSongs(songsDecorators: [SongDecorator]?)-> [Song]?{
        var songs: [Song] = []
        if(songsDecorators != nil){
            songsDecorators!.forEach{ decorator in
                songs.append(Song(songDecorator:decorator))
            }
            return songs
            }
        return nil
    }
    
    private func generateAlbums(albumDecorators: [AlbumDecorator]) ->[Album]?{
        var albums: [Album] = []
        if(albumDecorators != nil){
        albumDecorators.forEach{ decorator in
            albums.append(Album(albumDecorator: decorator, songs: generateSongs(songsDecorators: decorator as! [SongDecorator])!))
            }
            return albums
        }
        return nil
    }
    
    private func generateAlbumDecorators (songsDecorators: [SongDecorator]) -> [AlbumDecorator]{
        var decoratorAlbums: [AlbumDecorator] = []
        let groupByAlbum = Dictionary(grouping: songsDecorators){ song -> String in
            song.albumTitle!
        }
        
        groupByAlbum.forEach{ album in
            decoratorAlbums.append(AlbumDecorator(items: album.value))
        }
        
        return decoratorAlbums
        
    }
    
            


        
    func getAllSongsfromAlbum(albumName: String) -> [Song] {
        dataModel.getAllSongsfromAlbum(albumName: albumName)
        
    }
    
     func getAllSongs() -> [Song]{
        return songs
    }
    
     func getAllAlbums() -> [Album]{
        return albums
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

    class SongDecorator: MPMediaItem{
                
        func getSongDecorator() -> SongDecorator{
            return self
        }
             
        func getSongURL(fileName: String)-> URL {
            let urlpath  = Bundle.main.path(forResource: fileName, ofType: "mp3")
            return URL(fileURLWithPath: urlpath!)
        }

    }
    

    class AlbumDecorator: MPMediaItemCollection{
        
   
//        func setAlbumProperites(album: Album){
//            modelAlbum.name=self.value(forProperty: MPMediaPlaylistPropertyName) as! String
//            modelAlbum.descritpion=self.value(forProperty: MPMediaPlaylistPropertyDescriptionText) as? String
//            modelAlbum.image=self.representativeItem?.artwork?.image(at: CGSize(width: 500, height: 500)) ?? UIImage(named: "default_music")!
//
//        }

    }
    
   
  
    

    
}
