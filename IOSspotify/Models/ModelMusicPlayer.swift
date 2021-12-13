//
//  ModelMusicPlayer.swift
//  IOSspotify
//
//  Created by Michal Krukowski on 08/12/2021.
//
import Foundation
import MediaPlayer
import AVFoundation


struct ModelMusicPlayer{
    
    
    var currentAlbum: Album? = Album()
    var currentSong: Song? = Song()
    var isPlaying : Bool = false
    var player = AVPlayer()
    var expandMiniMusicPlayer = false
    
    
    
    mutating func setCurrentSong(song: Song){
            currentSong = song
    }
    
    mutating func setCurrentAlbum(album: Album){
        currentAlbum = album
    }
    
    mutating func isCurrentSongSet() -> Bool{
        if (currentSong != nil){
            return true
        }
        return false
    }
    

    mutating func playSong(){
        let url =  currentSong?.file
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback)
        }catch{
            //report error
        }
        isPlaying=true
        player = AVPlayer(url: url!)
        player.play()
    }
       
    
    mutating func playPause(){
        self.isPlaying.toggle()
        if isPlaying == false {
            player.pause()
        }else {
            //player.play()
            self.playSong()
        }
    }
    

    mutating func next() -> (Album, Song) {
        if let currentIndex = currentAlbum!.songs.firstIndex(of: currentSong!){
            if currentIndex == currentAlbum!.songs.count - 1{

            } else {
                player.pause()
                currentSong = currentAlbum!.songs[currentIndex + 1]
                self.playSong()
            }
        }
        return (currentAlbum!, currentSong!)
    }
    
        
    mutating func previous()  -> (Album, Song) {
        if let currentIndex = currentAlbum!.songs.firstIndex(of: currentSong!){
            if currentIndex == 0{
            } else {
                player.pause()
                currentSong = currentAlbum!.songs[currentIndex - 1]
                self.playSong()
            }
        }
        return (currentAlbum!, currentSong!)
    }
    
  
}
