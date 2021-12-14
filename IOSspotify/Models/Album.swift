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
    var name: String? = ""
    var image: UIImage = UIImage(named: "default_music") ?? UIImage()
    var songs : [Song]
    var albumDecorator : Data.AlbumDecorator?
    
    
    init(albumDecorator: Data.AlbumDecorator, songs: [Song]){
        self.name = albumDecorator.representativeItem?.albumTitle!
        self.image = albumDecorator.representativeItem?.artwork?.image(at: CGSize(width: 500, height: 500)) ?? UIImage(named: "default_background")!
        self.albumDecorator = albumDecorator
        self.songs = songs
    }
    
    
    init(name: String, songs: [Song]){
        self.albumDecorator = nil
        self.name = name
        self.songs = songs
        self.image = self.songs[0].image!
    }
    
    
    static func == (lhs: Album, rhs: Album) -> Bool {
        lhs.id == rhs.id
    }
    
    mutating func setAlbumProperties(name: String?,description: String?){
        self.name = name ?? "NA"
    }
    
    mutating func setAlbumProperties(albumDecorator: Data.AlbumDecorator){
        self.name = albumDecorator.representativeItem?.albumTitle!
        self.image = albumDecorator.representativeItem?.artwork?.image(at: CGSize(width: 500, height: 500)) ?? UIImage(named: "default_background")!
        self.albumDecorator = albumDecorator
       
    }
    
    
    
    
}
    
