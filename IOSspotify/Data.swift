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
    var playlists: [PlaylistModel]
    var update = false
    
    func getAllSongsfromAlbum(albumName: String) -> [Song] {
        albums.first {  album  in
            album.name == albumName
            
        }?.songs ?? []
    }
    
    mutating func updateView(){
        update.toggle()
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
    
    
    func getPlaylist(name: String) -> PlaylistModel? {
        let playlist =
            playlists.first{ playlist in
            playlist.name == name
        }
        return playlist ?? nil
    }
    
    
    func doesPlaylistContain(playlist: PlaylistModel, songName: String) ->Bool{
        playlist.isThereSong(songName: songName)
    }
    
    mutating func removePlaylist(name: String) {
        playlists.removeAll{ playlist in
            playlist.name == name
        }
    }
    
    mutating func addPlaylist(name: String, songs: [Song]){
        playlists.append(PlaylistModel(name: name, songs: songs))
    }
    
    mutating func addPlaylist(playlistModel: PlaylistModel){
        playlists.append(playlistModel)
    }
    
    mutating func setPlaylist(name: String, modifiedPlaylist: PlaylistModel){
        //removePlaylist(name: name)
        //addPlaylist(playlistModel: modifiedPlaylist)
        if let playlistIndex = playlists.firstIndex(of: getPlaylist(name: name)!){
            playlists[playlistIndex] = modifiedPlaylist
        }
    }

    
    
    mutating func addToPlaylist(song: Song, playlistName: String){
        var playlist = getPlaylist(name: playlistName)
        if (!doesPlaylistContain(playlist: playlist!, songName: song.name!)){
            playlist?.addSong(song: song)
            setPlaylist(name: playlistName, modifiedPlaylist: playlist!)

        }
    }
    
    mutating func deleteFromPlaylist(song: Song, playlistName: String){
        var playlist = getPlaylist(name: playlistName)
        playlist?.deleteSong(song: song)
        setPlaylist(name: playlistName, modifiedPlaylist: playlist!)
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
    
        var updateView = false
                                           
    @Published var dataModel : DataModel
    
    init(){
        let songDecorators = Data.generateSongDecoratorTable()
        let albumDecorators = Data.generateAlbumDecoratorTable()
        if !songDecorators.isEmpty{
            let songs = Data.generateSongs(songsDecorators: songDecorators)!
            let albums = Data.generateAlbums(albumDecorators: albumDecorators)!
            dataModel = DataModel(songs: songs, albums: albums, playlists: [PlaylistModel(name: "all", songs: songs),PlaylistModel(name: "favourites")])
        } else {
            dataModel = DataModel(songs: default_songs, albums: default_albums, playlists:[PlaylistModel(name: "all", songs: default_songs),PlaylistModel(name: "favourites")] )
        }
      
        print(dataModel.songs)
        print(dataModel.albums)
    }
    
    func updView(){
        dataModel.updateView()
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
    
    func getAllPlaylists() -> [PlaylistModel]{
        return dataModel.playlists
    }
    
    func getPlaylist(name: String) ->PlaylistModel?{
        return dataModel.getPlaylist(name: name)
    }
    
    func removePlaylist(name: String) {
        dataModel.removePlaylist(name: name)
    }
    
    
    func addPlaylist(name: String, songs: [Song]){
        dataModel.addPlaylist(name: name, songs: songs)
    }
    
    func addPlaylist(playlistModel: PlaylistModel){
        dataModel.addPlaylist(playlistModel: playlistModel)
    }
    
    func setPlaylist(name: String, modifiedPlaylist: PlaylistModel){
        dataModel.setPlaylist(name: name, modifiedPlaylist: modifiedPlaylist)
    }
    


    func addToPlaylist(song: Song, playlistName: String){
        
        dataModel.addToPlaylist(song: song, playlistName: playlistName)
    }
    
    
    func deleteFromPlaylist(song: Song, playlistName: String){
        dataModel.deleteFromPlaylist(song: song, playlistName: playlistName)
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
