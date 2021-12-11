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
        model.setCurrentSong(song: data.getSong(songName: userModel.lastListenedSong!) ??  Song(id: 0, name: "We Rock", time: "2:36", file: "song2"))
    }
    
    func setAlbumFromUserData(){
        model.setCurrentAlbum(album: data.getAlbum(albumName: userModel.lastListenedAlbum!) ??  Album(id: 0, name: "Camp Rock 1 & 2 Songs", image: "cover_1",
                                                                                                      songs: [Song(id: 0, name: "We Rock", time: "2:36", file: "song2"),
                                                                                                              Song(id: 1, name: "This is Me", time: "3:36", file: "song1"),
                                                                                                              Song(id: 2, name: "This is Our Song", time: "1:36", file: "song2"),
                                                                                                              Song(id: 3, name: "You are my favourite song", time: "2:26", file: "song1"),
                                                                                                              Song(id: 4, name: "Hasta la vista", time: "3:30", file: "song2")]))
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
    
    func getAlbumImageName()->String{
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
        
    }
    
    func playPause(){
        model.playPause()
    }
    
    func playSong(){
        if (!model.isCurrentSongSet()){
            setSongFromUserData()
            setAlbumFromUserData()
        }
        model.playSong()
    }
    
    func previous(){
        let (album, song) = model.previous()
        updateLastListenedSong(song: song.name)
        updateLastListenedAlbum(album: album.name)
       
      
    }
    
}
