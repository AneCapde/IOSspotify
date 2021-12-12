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
    var name: String = ""
    var artist: String = ""
    var time: String = ""
    var image: UIImage = UIImage(named: "default_image")!
    
    var file: String = ""
    
    init(){}
    
    init(fileName: String){
        file = fileName
        setSongProperties(fileName: fileName)
    }
    
    static func == (lhs: Song, rhs: Song) -> Bool {
        lhs.id == rhs.id
    }
    
    func getSongURL(fileName: String)-> URL {
        let urlpath  = Bundle.main.path(forResource: fileName, ofType: "mp3")
        return URL(fileURLWithPath: urlpath!)
    }
    
    func getSongURL() -> URL{
        let urlpath  = Bundle.main.path(forResource: self.file, ofType: "mp3")
        return URL(fileURLWithPath: urlpath!)
        
    }
    
    
    func getSongMetaData(fileName: String) -> [AVMetadataItem]?{
        let asset = AVAsset(url: URL(fileURLWithPath: fileName))
        return asset.commonMetadata
  
    }
    
    mutating func setSongProperties(fileName: String){
        if  let metadata = getSongMetaData(fileName: fileName){
        for data in metadata {
            if let stringValue = data.value{
                if data.commonKey?.rawValue == "title"{
                    name = (stringValue as? String) ?? "NA"
                }
                
                if data.commonKey?.rawValue == "artist"{
                    artist = (stringValue as? String) ?? "NA"
                }
            }
        }
        setSongImageName(fileName: fileName)
        }
        else{
            name = "NA"
            artist = "NA"
            image = UIImage(named: "default_image")!
        }
    }
    
    
    mutating func setSongImageName(fileName: String){
        let imageItems = AVMetadataItem.metadataItems(from: getSongMetaData(fileName: fileName)!, filteredByIdentifier: .commonIdentifierArtwork)
         if let imageName = imageItems.first{
            if let imageData = imageName.dataValue{
                self.image = UIImage(data: imageData)!
            }
        } else {
            self.image = UIImage(named: "default_image")!
            
        }
       
    }
        
    
}


