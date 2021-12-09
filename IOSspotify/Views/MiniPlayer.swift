//
//  MiniPlayer.swift
//  IOSspotify
//
//  Created by Michal Krukowski on 30/11/2021.
//


import SwiftUI
import AVFoundation

struct MiniPlayer: View {
    

    
    var animation: Namespace.ID
    @Binding var expand: Bool
    var height = UIScreen.main.bounds.height / 3
    @StateObject var data = Data()
    var lastListenedSong = UserDefaults.standard.string(forKey: "lastSong")
    
    @ObservedObject var viewModel : ViewModelMusicPlayer
 
   

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
                
                //FIGURE IT OUT USERDEFAULTS 
                Image(data.getAlbumImageName(songName: lastListenedSong ?? "cover1"))
                    .resizable()
                    .aspectRatio(contentMode:   .fill)
                    .frame(width: expand ? height : 55 , height: expand ? height :55)
                    .cornerRadius(15)
                
                if !expand{
                    Text(viewModel.getSongName())
                        .font(  .title2)
                        .fontWeight(    .bold)
                        .matchedGeometryEffect(id: "Label", in: animation)
                }
            
                Spacer(minLength: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/)
        
                if !expand{
                    ButtonsView(viewModel: viewModel)
                }
            }
            .padding(.horizontal)
        
            VStack(spacing: 15){
               
                Spacer(minLength: 0)

                HStack{
                    if expand {
                    Text(viewModel.getSongName())
                        .font(.title2)
                        .foregroundColor(.primary)
                        .fontWeight(.bold)
                        .matchedGeometryEffect(id: "Label", in: animation)
                
                    }
                }
                .padding(.top)
                
                HStack{ButtonsView(viewModel: viewModel)}
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
    

}
struct ButtonsView: View{
    
    @ObservedObject var viewModel : ViewModelMusicPlayer
    
    @AppStorage("lastSong", store: .standard) public var lastListenedSong: String = "No set"
    
    var body: some View{
        Spacer()
        Button(action: {
            viewModel.previous();            lastListenedSong = viewModel.getSongName();
                viewModel.updateLastListenedSong(song: lastListenedSong)        }, label: {
                Image(systemName:"backward.fill")
                    .font(.title2)
                    .foregroundColor(.primary)
            }
        
        
        )
        Spacer()
        Button(action: { viewModel.playPause();            lastListenedSong = viewModel.getSongName(); viewModel.updateLastListenedSong(song: lastListenedSong)
            
        },
        label: {
            Image(systemName:  viewModel.playingState())
                    .font(.title2)
                    .foregroundColor(.primary)
        })
        Spacer()
        Button(action: {viewModel.next();            lastListenedSong = viewModel.getSongName();
                viewModel.updateLastListenedSong(song: lastListenedSong)        }, label: {
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

