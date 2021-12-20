//
//  PlayList.swift
//  IOSspotify
//
//  Created by Ane Capdevila on 13/12/2021.
//
import MediaPlayer
import Foundation


class Playlist{
    
    @Published var playlistModel = PlaylistModel()
    
}


struct PlaylistModel: Hashable {
    
    static func == (lhs: PlaylistModel, rhs: PlaylistModel) -> Bool {
        lhs.id == rhs.id && lhs.name == rhs.name && lhs.songs == rhs.songs
    }
    
    var id = UUID()
    var name: String = ""
    var image: UIImage? = UIImage(named: "cover_3")
    var songs : [Song] = []
    
    
    init(name: String, songs: [Song]){
        self.name = name
        self.songs = songs
        
    }
    
    init(name: String){
        self.name = name
        
    }
    
    init(){
        self.name = id.uuidString
    }
    
    mutating func setPlaylist(playlist: PlaylistModel){
        self.name = playlist.name
        self.image = playlist.image
        self.songs = playlist.songs
    }
    
    mutating func addSong(song: Song){
        songs.append(song)
        if (self.image == UIImage(named: "cover_3")){
            self.image = song.image
        }
           
    }
    
    mutating func deleteSong(song: Song){
        songs.removeAll{ item in
            item.id == song.id
        }
        if (self.image == song.image && !songs.isEmpty){
            self.image = songs[0].image ?? UIImage(named: "cover_3")
        }
    }
    
    func getNumberOfSongs() -> Int{
        songs.count
    }
    
    func isEmpty() ->Bool{
        songs.isEmpty
    }
    
    func isThereSong(songName: String) ->Bool{
        songs.contains{ song in
            song.name == songName }
    }
    
    
}
    
