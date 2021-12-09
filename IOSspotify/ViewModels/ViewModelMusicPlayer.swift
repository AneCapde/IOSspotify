//  ViewModelMusicPlayer.swift
//  IOSspotifyAne
//
//  Created by Ane Capdevila on 19/11/2021.
//
import Foundation
import MediaPlayer
import AVFoundation


class ViewModelMusicPlayer: ObservableObject {
   
    @Published var model = ModelMusicPlayer2()
    @Published var userModel = User()
    
   
    func logingIn() ->Bool{
        userModel.logingIn()
    }
    
    func newUser(){
        userModel.newUser()
    }
    
    func updateLastListenedSong(song: String){
        userModel.lastListenedSong = song
    }
    
    
    func playingState() -> String  {
        if model.isPlaying{
            return "play.fill"
        }else{
            return "pause.fill"
        }
    }
    
    func getSongName()->String{
        model.currentSong.name
    }
    
    func getSong() -> Song{
        model.currentSong
    }
    
    func getAlbumImageName()->String{
        model.currentAlbum.image
    }
    
    func updateCurrentAlbum(album: Album)  {
        model.currentAlbum=album
    }
    
    func updateCurrentSong(song: Song)  {
        model.currentSong=song
    }
    
    func next(){
        model.next()
    }
    
    func playPause(){
        model.playPause()
    }
    
    func playSong(){
        model.playSong()
    }
    
    func previous(){
        model.previous()
    }
}
