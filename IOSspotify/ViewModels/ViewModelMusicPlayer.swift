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
    
    func isPlaying() -> Bool{
        model.isPlaying
    }

//    func setSongFromUserData(){
//        model.setCurrentSong(song: data.getSong(songName: userModel.lastListenedSong!)!)
//    }
//
//    func setAlbumFromUserData(){
//        model.setCurrentAlbum(album: data.getAlbum(albumName: userModel.lastListenedAlbum!)!)
//    }
    
    
    
    func updateTime(to: Float64){
        model.player.seek(to: CMTimeMakeWithSeconds(to, preferredTimescale: 1), toleranceBefore: CMTime.zero, toleranceAfter: CMTime.zero)
    }
   

    func logingIn() ->Bool{
        let isLogged = userModel.logingIn()
       // setSongFromUserData()
     //   setAlbumFromUserData()
        return isLogged
        
    }
    
    func newUser(){
        userModel.newUser()
    }
    
//    func updateLastListenedSong(song: String){
//        userModel.updateLastlistenedSong(name: song)
//    }
//
//    func updateLastListenedAlbum(album: String){
//        userModel.updateLastListenedAlbum(name: album)
//    }
    
    
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
    
    func updateCurrentSong(song: Song) {
        model.currentSong=song
    }
    
//
//    func setUserLastSong() {
//        model.currentSong = data.getSong(songName: userModel.lastListenedSong!)
//    }
//
//    func setUserLastAlbum(){
//        model.currentAlbum = data.getAlbum(albumName: userModel.lastListenedAlbum!)
//    }
    
    func next(){
        let (_, _) =  model.next()
        
       playSong()
        
    }
    
    func playPause(){
        model.playPause()
    }
    
    func playSong(){

        model.playSong()
//        model.player.currentItem?.addObserver(self as! NSObject, forKeyPath: #keyPath(AVPlayerItem.status), options:[.old, .new], context: nil)
    }
    
    func previous(){

//        model.player.currentItem?.removeObserver(self as! NSObject, forKeyPath: #keyPath(AVPlayerItem.status))
        let (_, _) = model.previous()

//        if (!model.isCurrentSongSet()){
//        //    setSongFromUserData()
//          //  setAlbumFromUserData()
//        }
        
        model.playSong()
    }
 
}
