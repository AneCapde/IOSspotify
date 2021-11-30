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
    @State var album : Album
    @State var song : Song
    @State var isPlaying : Bool = false
    @State var player = AVPlayer()
    var body: some View {
        
        VStack{
            
            HStack(spacing:15){
                
                Image(album.image)
                    .resizable()
                    .aspectRatio(contentMode:   .fill)
                    .frame(width: 55, height: 55)
                    .cornerRadius(15)
                
                Text("aa")
                    .font(  .title2)
                    .fontWeight(    .bold)
                
                Spacer(minLength: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/)
                
                HStack {
                    Button(action: self.previous, label: {
                            Image(systemName: "arrow.left.circle")
                                .resizable()
                    }).frame(width: 50, height: 50, alignment: .center).foregroundColor(Color.black.opacity(0.2))
                    Button(action: self.playPause, label: {
                            Image(systemName: isPlaying ? "play.circle.fill" : "pause.circle.fill")
                                .resizable()
                    }).frame(width: 70, height: 70, alignment: .center)
                    Button(action: self.next, label: {
                            Image(systemName: "arrow.right.circle")
                                .resizable()
                    }).frame(width: 50, height: 50, alignment: .center).foregroundColor(Color.black.opacity(0.2))
                }
            }.edgesIgnoringSafeArea(.bottom).frame(height: 200, alignment: .center)
        }
    }
    
        func playSong(playingSong: String){
            let urlpath     = Bundle.main.path(forResource: playingSong, ofType: "mp3")
            let url =  URL(fileURLWithPath: urlpath!)
            do {
                try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback)
            }catch{
                //report error
            }
            player = AVPlayer(url: url)
            player.play()
        }
        func playPause(){
            self.isPlaying.toggle()
            if isPlaying == false {
                player.pause()
            }else {
                player.play()
            }
        }
        func next() {
            if let currentIndex = album.songs.firstIndex(of: song){
                if currentIndex == album.songs.count - 1{
                    
                } else {
                    player.pause()
                    song = album.songs[currentIndex + 1]
                    self.playSong(playingSong: song.file)
                }
            }
        }
        func previous() {
            if let currentIndex = album.songs.firstIndex(of: song){
                if currentIndex == 0{
                    
                } else {
                    player.pause()
                    song = album.songs[currentIndex - 1]
                    self.playSong(playingSong: song.file)
                }
            }
    }
}

                
                


//struct MiniPlayer_Previews: PreviewProvider {
//    static var previews: some View {
//     MiniPlayer()
//    }
//}

