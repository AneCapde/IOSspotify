//
//  ModelMusicPlayer.swift
//  music_player_app
//
//  Created by Michalina Janik on 07/11/2021.
//
import Foundation
import MediaPlayer
import AVFoundation


class ModelMusicPlayer: ObservableObject{
    
    static let singletonMusicPlayer = ModelMusicPlayer()
        
    @Published var currentSong: MPMediaItem?
    @Published var playlists = [MPMediaItemCollection]()
    @Published var librarySongs = [MPMediaItem]()
    
    @Published var audio: AVAudioPlayer?
    
    
    
    
  
    
    
    
    
}
