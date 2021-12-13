//
//  Album.swift
//  IOSspotifyAne
//
//  Created by Ane Capdevila on 17/11/2021.
//
import Foundation
import MediaPlayer

struct Album: Hashable {
  
    let id = UUID()
    var name: String = ""
    var descritpion: String? = ""
    var image: UIImage = UIImage(named: "default_music") ?? UIImage()
    var songs : [Song] = []
    
    init(){}
    
    init(name: String, songs: [Song]){
        self.name = name
        self.songs = songs
        self.image = self.songs[0].image!
    }
    
    static func == (lhs: Album, rhs: Album) -> Bool {
        lhs.id == rhs.id
    }
    
    mutating func setAlbumProperties(name: String?,description: String?){
        self.name=name ?? "NA"
        self.descritpion = description ?? " "
        
    }
    
    
}
    
