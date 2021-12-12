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
   

    private var data = Data()
    @Published var userModel = User()
    @Published var model = ModelMusicPlayer()
    
   

    func setSongFromUserData(){
        model.setCurrentSong(song: data.getSong(songName: userModel.lastListenedSong!) ?? data.getAllSongs()[0])
    }
    
    func setAlbumFromUserData(){
        model.setCurrentAlbum(album: data.getAlbum(albumName: userModel.lastListenedAlbum!) ?? data.getAllAlbums()[0])
    }
    
    
    func logingIn() ->Bool{
        let isLogged = userModel.logingIn()
        setSongFromUserData()
        setAlbumFromUserData()
        return isLogged
        
    }
    
    func newUser(){
        userModel.newUser()
    }
    
    func updateLastListenedSong(song: String){
        userModel.updateLastlistenedSong(name: song)
    }
    
    func updateLastListenedAlbum(album: String){
        userModel.updateLastListenedAlbum(name: album)
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
    
    func getAlbumImageName()->UIImage{
        model.currentAlbum!.image
    }
    
    func updateCurrentAlbum(album: Album)  {
        model.currentAlbum=album
    }
    
    func updateCurrentSong(song: Song) {
        model.currentSong=song
    }
    
    
    func setUserLastSong() {
        model.currentSong = data.getSong(songName: userModel.lastListenedSong!)
    }
    
    func setUserLastAlbum(){
        model.currentAlbum = data.getAlbum(albumName: userModel.lastListenedAlbum!)
    }
    
    func next(){
        let (album, song) =  model.next()
        updateLastListenedSong(song: song.name)
        updateLastListenedAlbum(album: album.name)
       // playSong()
        
    }
    
    func playPause(){
        model.playPause()
    }
    
    func playSong(){
        if (!model.isCurrentSongSet()){
            setSongFromUserData()
            setAlbumFromUserData()
        }
       // model.playSong()
    }
    
    func previous(){
        let (album, song) = model.previous()
        updateLastListenedSong(song: song.name)
        updateLastListenedAlbum(album: album.name)
        playSong()
       
    }
    
}
