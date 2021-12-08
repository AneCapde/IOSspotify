//
//  MiniPlayer.swift
//  IOSspotify
//
//  Created by Michal Krukowski on 30/11/2021.
//


import SwiftUI
import AVFoundation

struct MiniPlayer: View {
    
//    @State var album : Album
//    @State var song : Song
//    @State var isPlaying : Bool = false
//    @State var player = AVPlayer()
    var animation: Namespace.ID
    @Binding var expand: Bool
    var height = UIScreen.main.bounds.height / 3
 
    var safeArea = UIApplication.shared.windows.first?.safeAreaInsets
    
    // TODO
    // get phone volume value
    @State var volume: CGFloat = 0.5
    
    @State var offset:CGFloat = 0
    
    var body: some View {
        
        VStack{
            
            Capsule()
                .fill(Color.gray)
                .frame(width: expand ? 60 : 0, height: expand ? 4 : 0)
                .opacity(expand ? 1 : 0)
                .padding(.top,expand ? safeArea?.top : 0)
                .padding(.vertical, expand ? 30 : 0)
            
            HStack(spacing:15){

                if expand{Spacer(minLength: 0)}
                
                Image("cover_1")
                    .resizable()
                    .aspectRatio(contentMode:   .fill)
                    .frame(width: expand ? height : 55 , height: expand ? height :55)
                    .cornerRadius(15)
                
                if !expand{
                    Text("aa")
                        .font(  .title2)
                        .fontWeight(    .bold)
                        .matchedGeometryEffect(id: "Label", in: animation)
                }
            
                Spacer(minLength: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/)
        
                if !expand{
                    ButtonsView()
                }
            }
            .padding(.horizontal)
        
            VStack(spacing: 15){
               
                Spacer(minLength: 0)

                HStack{
                    if expand {
                    Text("aa")
                        .font(.title2)
                        .foregroundColor(.primary)
                        .fontWeight(.bold)
                        .matchedGeometryEffect(id: "Label", in: animation)
                
                    }
                }
                .padding(.top)
                
                HStack{ButtonsView()}
                Spacer(minLength: 0)
                
                HStack(spacing: 15){
                    
                    Image(systemName: "speaker.fill")
                    
                    Slider(value: $volume)
                    
                    Image(systemName: "speaker.wave.2.fill")
                }.padding()
                
                Spacer()
                
               
                
                
            }
            .frame(height: expand ? nil : 0 )
            .opacity(expand ? 1 : 0)
        }
        // to full screen
        .frame(maxHeight: expand ? .infinity:  80)
        // DEVIDER FOR SEPARATING MINIP AND TBAR
        .background(
            
            
            
            VStack(spacing: 0){
                Blur()
                Divider()
            }
            .onTapGesture {
                withAnimation(.spring()){expand = true}
            }
        )
        .cornerRadius(expand ? 20: 0)
        .offset( y: expand ? 0 : -48)
        .offset(y: offset)
        .gesture(DragGesture().onEnded(onEnd(value: )).onChanged(onChange(value: )))
        .ignoresSafeArea()
    }
        
    func onChange(value: DragGesture.Value){
        //works only when expanded
        if value.translation.height > 0 && expand{
            offset=value.translation.height
        }
    }
    
    func onEnd(value: DragGesture.Value){
        withAnimation(.interactiveSpring(response: 0.5, dampingFraction: 0.95,blendDuration: 0.95 )){
            // if val > height/3 then close view
            if value.translation.height > height {
                expand=false
            }
            offset=0
        }
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
struct ButtonsView: View{

    var body: some View{
        Spacer()
        Button(action: {}, label: {
                Image(systemName:"backward.fill")
                    .font(.title2)
                    .foregroundColor(.primary)
            
        })
        Spacer()
        Button(action: {}, label: {
                Image(systemName: "play.fill")
                    .font(.title2)
                    .foregroundColor(.primary)
        })
        Spacer()
        Button(action: {}, label: {
                Image(systemName:"forward.fill")
                    .font(.title2)
                    .foregroundColor(.primary)
                   
        })
        Spacer()
    }
}
//struct MiniPlayerPreview: PreviewProvider {
//    static var previews: some View {
//        MiniPlayer(animation: animation, expand: $expand)
//    }
//}

