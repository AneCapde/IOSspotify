//  ViewModelMusicPlayer.swift
//  IOSspotifyAne
//
//  Created by Ane Capdevila on 19/11/2021.
//
import Foundation
import MediaPlayer
import AVFoundation
import SwiftUI

class ViewModelMusicPlayer: ObservableObject {
   
    
    @Published var model = ModelMusicPlayer()
    @Published var userModel = User()
    @ObservedObject var data = Data()
    
    
    func setCurrentSong(){
        model.setCurrentSong(song: data.getSong(songName: userModel.lastListenedSong!)!)
    }
    
    func logingIn() ->Bool{
        userModel.logingIn()
    }
    
    func newUser(){
        userModel.newUser()
    }
    
    func updateLastListenedSong(song: String){
        userModel.updateLastlistenedSong()
    }
    
    
    func getPlayer() -> AVPlayer{
        model.player
    }
    
    func playingState() -> String  {
        if model.isPlaying{
            return "pause.fill"
        }else{
            return "play.fill"
        }
    }
    func changeStateOdExpand(expand: Bool){
        model.expandMiniMusicPlayer = expand
    }
    
    func expand()-> Bool{
        model.expandMiniMusicPlayer
    }
    
    func getSongName()->String{
        model.currentSong!.name
    }
    
    func getSong() -> Song{
        model.currentSong!
    }
    
    func getAlbumImageName()->String{
        model.currentAlbum.image
    }
    
    func updateCurrentAlbum(album: Album)  {
        model.currentAlbum=album
    }
    
    func updateCurrentSong() {
        
        model.currentSong = data.getSong(songName: userModel.lastListenedSong ?? "We Rock")
        
        
    }
    
    func next(){
        let (_, song) =  model.next()
        updateLastListenedSong(song: song.name)
        
    }
    
    func playPause(){
        model.playPause()
    }
    
    func playSong(){
        if (!model.isCurrentSongSet()){
           updateCurrentSong()
        }
        model.playSong()
        
    }
    
    func previous(){
        let (_, song) = model.previous()
        updateLastListenedSong(song: song.name)
        
        
    }
    
}
