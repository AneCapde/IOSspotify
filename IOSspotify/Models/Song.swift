//
//  Song.swift
//  IOSspotifyAne
//
//  Created by Ane Capdevila on 17/11/2021.
//
import Foundation
import MediaPlayer

struct Song : Hashable {
    
    let id = UUID()
    var name: String? = ""
    var artist: String? = ""
    var time: Double? = 0.0
    var image: UIImage? = UIImage(named: "default_image")!
    var file: URL = URL(fileURLWithPath: "/IOSspotify/Audio")
    
    mutating func setSongProperties(artist: String?, name: String?, image: UIImage?, time: Double?, file: String){
        self.artist=artist ?? "NA"
        self.name=name ?? "NA"
        self.image=image ?? UIImage(named: "default_background")
        self.time=time ?? 0.0
    }
    

    
}




