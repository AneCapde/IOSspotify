//
//  Song.swift
//  IOSspotifyAne
//
//  Created by Ane Capdevila on 17/11/2021.
//
import Foundation
import MediaPlayer

let DEFAULT_URL:URL = URL(fileURLWithPath: "/IOSspotify/Audio")

extension Song: CustomStringConvertible {
    var description: String{
        return "Song title: \(String(describing: name!)), \nArtist:  \(String(describing: artist!))"
    }
}

struct Song : Hashable {
    
    let id = UUID()
    var name: String? = "unknown"
    var artist: String? = "unknown"
    var time: Double? = 0.0
    var image: UIImage? = UIImage(named: "default_image")
    var url: URL = DEFAULT_URL
    var fileName: String = " "
    var songDecorator=Data.SongDecorator()
    var album: String? = " "
    
    init(){
//        self.name = ""
//        self.artist""
//        self.time = 0.0
//        self.image = UIImage(named: "default_image")
//        self.url = DEFAULT_URL
//        self.fileName = " "
//        self.songDecorator = Data.SongDecorator()
//        self.album  = " "
    }
    
    init(songDecorator: Data.SongDecorator){
        setSongProperties(songDecorator: songDecorator)
    }
    
    init(name: String?, time: Double?, fileName: String){
        self.name=name ?? "NA"
        self.time=time ?? 0.0
        self.fileName = fileName
    }
    
    static func ==(lhr: Song, rhl: Song) -> Bool{
       lhr.fileName == rhl.fileName && lhr.artist == rhl.artist
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
        self.time=songDecorator.playbackDuration
        self.songDecorator = songDecorator
        self.url=songDecorator.assetURL!
    }
    
    

    
}
