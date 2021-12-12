//
//  PlayingView.swift
//  IOSspotifyAne
//
//  Created by Ane Capdevila on 17/11/2021.
//
import SwiftUI
import AVFoundation

struct PlayingView: View {
    
    @State var album : Album
    @State var song : Song
    @State var isPlaying : Bool = false
    @State var player = AVPlayer()
    @State var time: CGFloat = 0.5
    
    var body: some View {
        ZStack{
            Image(album.image)
                .resizable()
                .edgesIgnoringSafeArea(.all)
            Blur(style: .dark).edgesIgnoringSafeArea(.all)
            
            VStack{
                Spacer()
                AlbumArt(album: album, isWithText: false)
                Text(song.name).font(.title).fontWeight(.light).foregroundColor(.white)
                Spacer()
                ZStack{
                    Color.white.cornerRadius(20).shadow(radius: 10)
                    VStack{
                        
//                        Slider(value: $time)
//                            .padding()

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
                    }
                }.edgesIgnoringSafeArea(.bottom).frame(height: 200, alignment: .center)
            }
        }.onAppear(){
            playSong(playingSong: song.file)
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
