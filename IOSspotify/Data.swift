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
    
    //static var  songs: [Song] = [Song]()
    //static var  albums: [Album] = [Album]()
                                     
      let default_songs: [Song] = [Song(name: "We Rock", time: 156.0, fileName: "song1"),
                                        Song(name: "This is Me", time: 225.5, fileName: "song2")]
    
      let default_albums: [Album] = [Album(name: "Katy Perry", songs: [Song(name: "We Rock", time: 156.0, fileName: "song1"),
                                                                            Song(name: "This is Me", time: 225.5, fileName: "song2")])]
                                           
    @Published var dataModel : DataModel
    
    init(){
        let songDecorators = Data.generateSongDecoratorTable()
        let albumDecorators = Data.generateAlbumDecoratorTable()
        if !songDecorators.isEmpty{
            let songs = Data.generateSongs(songsDecorators: songDecorators)!
            let albums = Data.generateAlbums(albumDecorators: albumDecorators)!
            dataModel = DataModel(songs: songs, albums: albums)
        } else {
            dataModel = DataModel(songs: default_songs, albums: default_albums)
        }
      
        print(dataModel.songs)
        print(dataModel.albums)
    }
    

    private static func generateSongDecoratorTable() -> [MPMediaItem]{
        var songTable = [MPMediaItem]()
        SKCloudServiceController.requestAuthorization{ status in
            if status == .authorized{
                let songQuery = MPMediaQuery.songs()
               
                if let userSongs = songQuery.items {
                    
                    //let sortByPlayedDate = NSSortDescriptor(key: MPMediaItemPropertyLastPlayedDate, ascending: false)
                    //songTable.append(contentsOf: userSongs)//.sortedArray(using: [sortByPlayedDate]) as! [SongDecorator]
                    for song in userSongs{
                        print("Library query Songs - \(song)")
                        songTable.append(song)
                    }
                   
                }
               
            }
             
        }
        return songTable
    }
    
    private static  func generateSongs(songsDecorators: [MPMediaItem]?)-> [Song]?{
        var songs: [Song] = []
        if(songsDecorators != nil){
            songsDecorators!.forEach{ decorator in
                songs.append(Song(songDecorator: decorator  as! Data.SongDecorator))
            }
            return songs
            }
        return nil
    }
    
    private static func generateAlbums(albumDecorators: [MPMediaEntity]?) ->[Album]?{
        var albums: [Album] = []
        if(albumDecorators != nil){
        albumDecorators!.forEach{ decorator in
            albums.append(Album(albumDecorator: decorator  as! Data.AlbumDecorator, songs: generateSongs(songsDecorators: (decorator as! MPMediaItemCollection).items )!))
            }
            return albums
        }
        return nil
    }
    
    private func generateAlbumDecoratorFromSongs (songsDecorators: [SongDecorator]) -> [AlbumDecorator]{
        var decoratorAlbums: [AlbumDecorator] = []
        let groupByAlbum = Dictionary(grouping: songsDecorators){ song -> String in
            song.albumTitle!
        }
        
        groupByAlbum.forEach{ album in
            decoratorAlbums.append(AlbumDecorator(items: album.value))
        }
        
        return decoratorAlbums
        
    }
    
    private static  func generateAlbumDecoratorTable() -> [MPMediaEntity]{
        var albumTable: [MPMediaEntity] = []
        SKCloudServiceController.requestAuthorization{ status in
            if status == .authorized{
                let albumQuery = MPMediaQuery.albums()
                if let userAlbums = albumQuery.items {
                    //let sortByPlayedDate = NSSortDescriptor(key: //MPMediaItemPropertyLastPlayedDate, ascending: false)
                     albumTable = userAlbums // NSArray(array: userAlbums).sortedArray(using: [sortByPlayedDate]) as! [AlbumDecorator]
                   
                }
               
            }
             
        }
        return albumTable
    }
    
    
            


        
    func getAllSongsfromAlbum(albumName: String) -> [Song] {
        dataModel.getAllSongsfromAlbum(albumName: albumName)
        
    }
    
     func getAllSongs() -> [Song]{
        return dataModel.songs
    }
    
     func getAllAlbums() -> [Album]{
        return dataModel.albums
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

        override func value(forProperty property: String) -> Any? {
            return nil
        }
    }

    class AlbumDecorator: MPMediaItemCollection{

    }
    
   
  
    

    
}
