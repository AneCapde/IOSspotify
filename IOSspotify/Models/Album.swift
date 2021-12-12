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
    var image = UIImage(named: "default_image")!
    
    var songs : [Song] = []
    
    init(){}
    
    init(name: String, songs: [Song]){
        self.name = name
        self.songs = songs
        self.image = self.songs[0].image
    }
    
    static func == (lhs: Album, rhs: Album) -> Bool {
        lhs.id == rhs.id
    }
    
    
}
    
