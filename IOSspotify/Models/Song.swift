//
//  Song.swift
//  IOSspotifyAne
//
//  Created by Ane Capdevila on 17/11/2021.
//
import Foundation
import MediaPlayer

struct Song : Hashable {
    var id : Int64 = 0
    var name: String = ""
    var time: String = ""
    var file: String = ""
    
    func getSongURL()-> URL {
        let urlpath  = Bundle.main.path(forResource: self.file, ofType: "mp3")
        return URL(fileURLWithPath: urlpath!)
    }
    
    func getSongMetaData() ->[AVMetadataItem]{
        let asset = AVAsset(url: self.getSongURL())
        return asset.commonMetadata
  
    }
    
    
}


