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
       
    private let songDecorator: SongDecorator
    private let albumDecorator: AlbumDecorator
    
    var songs: [Song] = []
    var albums: [Album] = []
                                     
    static let default_songs: [Song] = [Song(name: "We Rock", time: 156.0),
                                        Song(name: "This is Me", time: 225.5)]
    static let default_albums: [Album] = [Album(name: "Katy Perry", songs: default_songs)]
                                           
    @Published var dataModel = DataModel(songs: default_songs, albums: default_albums)
    
    init(){
        songDecorator = SongDecorator()
        albumDecorator = AlbumDecorator()
        let songsTable = generateSongTable()
        setAllSongs(songlist: songsTable)
        songs = songsTable
        let allAlbums = getDefaultAlbum(songs: songs)
        albums = [allAlbums]
    }
    
    func setAllSongs(songlist: [Song]){
        songDecorator.setAllSongs(songlist: songlist)
    }
    
    func getDefaultAlbum(songs: [Song]) -> Album{
        return albumDecorator.getDefaultAlbum(songlist: songs)
    }

    class SongDecorator: MPMediaItem{
        
        @Published var modelSong = Song()
        
        func setSongProperites(song: Song){
            modelSong.artist=self.artist ?? "NA"
            modelSong.name=self.title ?? "NA"
            modelSong.image=self.artwork?.image(at: CGSize(width: 500, height: 500)) ?? UIImage(named: "default_background") ?? UIImage()
            modelSong.time=self.playbackDuration
            modelSong.file=self.assetURL!
        
        }
        
        func setAllSongs(songlist: [Song]){
            for song in songlist{
                setSongProperites(song: song)
            }
        }
        
        
        

        func getSongURL(fileName: String)-> URL {
            let urlpath  = Bundle.main.path(forResource: fileName, ofType: "mp3")
            return URL(fileURLWithPath: urlpath!)
        }

    }
    

    class AlbumDecorator: MPMediaItemCollection{
        
        @Published var modelAlbum = Album()
        
        func setAlbumProperites(album: Album){
            modelAlbum.name=self.value(forProperty: MPMediaPlaylistPropertyName) as! String
            modelAlbum.descritpion=self.value(forProperty: MPMediaPlaylistPropertyDescriptionText) as! String
            modelAlbum.image=self.representativeItem?.artwork?.image(at: CGSize(width: 500, height: 500)) ?? UIImage(named: "default_music")!
           
        
        }
        
        func getDefaultAlbum( songlist: [Song] ) ->Album{
            let album = Album(name: "All", songs: songlist)
            modelAlbum.name="All"
            modelAlbum.songs=songlist
            modelAlbum.image=songlist[0].image!
            return album
            
        }
        
    

        func getSongURL(fileName: String)-> URL {
            let urlpath  = Bundle.main.path(forResource: fileName, ofType: "mp3")
            return URL(fileURLWithPath: urlpath!)
        }

    }
    
   
    private func generateSongTable() -> [Song]{
        var songTable: [Song] = []
        SKCloudServiceController.requestAuthorization{ status in
            if status == .authorized{
                let songQuery = MPMediaQuery.songs()
                if let userSongs = songQuery.items {
                    let sortByPlayedDate = NSSortDescriptor(key: MPMediaItemPropertyLastPlayedDate, ascending: false)
                     songTable = NSArray(array: userSongs).sortedArray(using: [sortByPlayedDate]) as! [Song]
                   
                }
               
            }
             
        }
        return songTable
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
    

    
}
