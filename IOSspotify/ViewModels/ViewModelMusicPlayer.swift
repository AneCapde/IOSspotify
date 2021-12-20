
//  IOSspotifyAne
//
//  Created by Ane Capdevila on 19/11/2021.
//
import Foundation
import MediaPlayer
import AVFoundation


class ViewModelMusicPlayer: ObservableObject {
    
    @Published var model = ModelMusicPlayer()
    @Published var userModel = User()
    @Published var lastListenedSong = UserDefaults.standard.string(forKey: "lastSong")
    @Published var lastListenedAlbum = UserDefaults.standard.string(forKey: "lastAlbum")
   
    
    //    func addPlayList(playlist: Playlist){
    //        userModel.addPlaylist(playlist: playlist)
    //        //userModel.setPlaylist()
    //    }
    
    //    func getPlayLists() -> [Playlist] {
    //        return playlist
    //    }
    
    func isPlaying()->Bool{
        model.isPlaying
    }
    
    
    func displayInfo(song: Song) -> String{
        model.displayInfo(song: song)
    }
    
    func newUser(){
        userModel.newUser()
    }
    func logingIn() ->Bool{
        let isLogged = userModel.logingIn()
        return isLogged
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
    
    func getSongName()->String?{
        model.currentSong.name
    }
    
    
    func getSong() -> Song{
        model.currentSong
    }
    
    
    func getAlbumImageName()->UIImage{
        model.currentAlbum.image
    }
    func updatePlayer(){
        model.createPlayer()
    }
    func updateCurrentAlbum(album: Album)  {
        
        model.currentAlbum = album
    }
    
    func updateCurrentSong(song: Song)  {
        model.currentSong = song
        model.player.replaceCurrentItem(with: AVPlayerItem(url: song.getSongURL()))
    }
    func returnCurrentSong() -> Song? {
        model.currentSong
    }
    func returnCurrentAlbum() -> Album {
        model.currentAlbum
    }
    func next(){
        model.next()
    }
    
    //
    //    func setUserLastSong() {
    //        model.currentSong = data.getSong(songName: userModel.lastListenedSong!)
    //    }
    //
    //    func setUserLastAlbum(){
    //        model.currentAlbum = data.getAlbum(albumName: userModel.lastListenedAlbum!)
    //    }
    
    
    func playPause(){
        model.playPause()
    }
    
    func playSong(){
        
        model.playSong()
    }
    
    func previous(){
        model.previous()
    }
    
    
    //        model.player.currentItem?.addObserver(self as! NSObject, forKeyPath: #keyPath(AVPlayerItem.status), options:[.old, .new], context: nil)
    
    
    
    
}
