//
//  Song.swift
//  IOSspotifyAne
//
//  Created by Ane Capdevila on 17/11/2021.
//
import Foundation
import MediaPlayer

let DEFAULT_URL:URL = URL(fileURLWithPath: "/IOSspotify/Audio")

struct Song : Hashable {
    
    let id = UUID()
    var name: String? = ""
    var artist: String? = ""
    var time: Double? = 0.0
    var image: UIImage? = UIImage(named: "default_image")!
    var url: URL = DEFAULT_URL
    var fileName: String = " "
    var songDecorator=Data.SongDecorator()
    var album: String? = " "
    
    
    init(songDecorator: Data.SongDecorator){
        setSongProperties(songDecorator: songDecorator)
    }
    
    init(name: String?, time: Double?, fileName: String){
        self.name=name ?? "NA"
        self.time=time ?? 0.0
        self.fileName = fileName
    }
    
    func getSongURL()-> URL {
        if(self.url != DEFAULT_URL){
            return self.url
            
        }
        else{
            let urlpath  = Bundle.main.path(forResource: self.fileName, ofType:"mp3")
                    return URL(fileURLWithPath: urlpath!)
        }
            
      }
    
    
    
    
    
    mutating func setSongProperties(artist: String?, name: String?, image: UIImage?, time: Double?, file: String){
        self.artist=artist ?? "NA"
        self.name=name ?? "NA"
        self.image=image ?? UIImage(named: "default_background")
        self.time=time ?? 0.0
    }
    
    mutating func setSongProperties(songDecorator: Data.SongDecorator){
        self.artist=songDecorator.artist ?? "NA"
        self.name=songDecorator.title ?? "NA"
        self.image=songDecorator.artwork?.image(at: CGSize(width: 500, height: 500)) ?? UIImage(named: "default_background")
        self.time=songDecorator.playbackDuration ?? 0.0
        self.songDecorator = songDecorator
        self.url=songDecorator.assetURL!
    }
    

    
}




