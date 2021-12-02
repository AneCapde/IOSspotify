//
//  MiniPlayer.swift
//  IOSspotify
//
//  Created by Michal Krukowski on 30/11/2021.
//




//NOT WORKING !!!!
import SwiftUI
import AVFoundation

struct MiniPlayer: View {
    
//    @State var album : Album
//    @State var song : Song
//    @State var isPlaying : Bool = false
//    @State var player = AVPlayer()
    
    var body: some View {
        
        VStack{
            
            HStack(spacing:15){
                
                Image("cover_1")
                    .resizable()
                    .aspectRatio(contentMode:   .fill)
                    .frame(width: 55, height: 55)
                    .cornerRadius(15)
                
                Text("aa")
                    .font(  .title2)
                    .fontWeight(    .bold)
                
                Spacer(minLength: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/)
                
                HStack {
                    Button(action: {}, label: {
                            Image(systemName: "play.fill")
                                .font(.title2)
                                .foregroundColor(.primary)
                    })
                    
                    Button(action: {}, label: {
                            Image(systemName:"forward.fill")
                                .font(.title2)
                                .foregroundColor(.primary)
                               
                    })
                
                }
            }
            .padding(.horizontal)
        }
        .frame(height: 80)
        
        
        // DEVIDER FOR SEPARATING MINIP AND TBAR
        .background(
            
            VStack(spacing: 0){
                Blur()
                Divider()
            }
        )
        .offset( y: -48)
        
    }
    
//        func playSong(playingSong: String){
//            let urlpath     = Bundle.main.path(forResource: playingSong, ofType: "mp3")
//            let url =  URL(fileURLWithPath: urlpath!)
//            do {
//                try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback)
//            }catch{
//                //report error
//            }
//            player = AVPlayer(url: url)
//            player.play()
//        }
//        func playPause(){
//            self.isPlaying.toggle()
//            if isPlaying == false {
//                player.pause()
//            }else {
//                player.play()
//            }
//        }
//        func next() {
//            if let currentIndex = album.songs.firstIndex(of: song){
//                if currentIndex == album.songs.count - 1{
//
//                } else {
//                    player.pause()
//                    song = album.songs[currentIndex + 1]
//                    self.playSong(playingSong: song.file)
//                }
//            }
//        }
//        func previous() {
//            if let currentIndex = album.songs.firstIndex(of: song){
//                if currentIndex == 0{
//
//                } else {
//                    player.pause()
//                    song = album.songs[currentIndex - 1]
//                    self.playSong(playingSong: song.file)
//                }
//            }
 //   }
}
