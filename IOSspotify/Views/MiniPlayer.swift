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
    var height = UIScreen.main.bounds.height / 3
    
    @ObservedObject var viewModel : ViewModelMusicPlayer
    
    
    var safeArea = UIApplication.shared.windows.first?.safeAreaInsets
    
    @State var timer = Timer.publish(every: 1, on: .current, in:.default).autoconnect()
    
    @State var volume: CGFloat = 0.5
   

    @State var time: CGFloat = 0

    @State var offset:CGFloat = 0
    
    var body: some View {
        
        VStack{
            
            Capsule()
                .fill(Color.gray)
                .frame(width: viewModel.expand() ? 60 : 0, height: viewModel.expand() ? 4 : 0)
                .opacity(viewModel.expand() ? 1 : 0)
                .padding(.top,viewModel.expand() ? safeArea?.top : 0)
                .padding(.vertical, viewModel.expand() ? 30 : 0)
            
            HStack(spacing:15){

                if viewModel.expand(){Spacer(minLength: 0)}
                
                //FIGURE IT OUT USERDEFAULTS 
                Image(uiImage: viewModel.getAlbumImageName())
                    .resizable()
                    .aspectRatio(contentMode:   .fill)
                    .frame(width: viewModel.expand() ? height : 55 , height: viewModel.expand() ? height :55)
                    .cornerRadius(15)
                
                if !viewModel.expand(){
                    Text(viewModel.getSongName())
                        .font(  .title3)
                        .fontWeight(.thin)
                        .matchedGeometryEffect(id: "Label", in: animation)
                        
                }
            
                Spacer(minLength: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/)
        
                if !viewModel.expand(){
                    ButtonsView(viewModel: viewModel)
                }
            }
            .padding(.horizontal)
        
            VStack(spacing: 15){
               
                Spacer(minLength: 0)

                HStack{
                    if viewModel.expand() {
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
                    
                    //Image(systemName: "speaker.fill")
                    
                    Slider(value: $time)
                        .onReceive(timer, perform: { _ in
                            self.updateTimer()
                        })
                    
                    //Image(systemName: "speaker.wave.2.fill")
                }.padding()
                
                Spacer()
                
               
                
                
            }
            .frame(height: viewModel.expand() ? nil : 0 )
            .opacity(viewModel.expand() ? 1 : 0)
        }
        // to full screen
        .frame(maxHeight: viewModel.expand() ? .infinity:  80)
        // DEVIDER FOR SEPARATING MINIP AND TBAR
        .background(
            
            
            
            VStack(spacing: 0){
                Blur()
                Divider()
            }
            .onTapGesture {
                withAnimation(.spring()){viewModel.changeStateOdExpand(expand: true)}
            }
        )
        .cornerRadius(viewModel.expand() ? 20: 0)
        .offset( y: viewModel.expand() ? 0 : -48)
        .offset(y: offset)
        .gesture(DragGesture().onEnded(onEnd(value: )).onChanged(onChange(value: )))
        .ignoresSafeArea()
    }
        
    func onChange(value: DragGesture.Value){
        //works only when expanded
        if value.translation.height > 0 && viewModel.expand(){
            offset=value.translation.height
        }
    }
    
    func onEnd(value: DragGesture.Value){
        withAnimation(.interactiveSpring(response: 0.5, dampingFraction: 0.95,blendDuration: 0.95 )){
            // if val > height/3 then close view
            if value.translation.height > height {
                viewModel.changeStateOdExpand(expand: false)
            }
            offset=0
        }
    }
    func updateTimer(){
        if (viewModel.expand() == true){
            let currentTime: CMTime = viewModel.getPlayer().currentTime()
            let total: CMTime? = viewModel.getPlayer().currentItem?.asset.duration
            
            let progress: Float = Float(CMTimeGetSeconds(currentTime))/Float(CMTimeGetSeconds(total!))

            withAnimation(Animation.linear(duration:0.1)){
                self.time = CGFloat(progress)
            }
        }
    }
    

}
struct ButtonsView: View{
    
    @ObservedObject var viewModel : ViewModelMusicPlayer
    
    var body: some View{
        Spacer()
        Button(action:
                 viewModel.previous, label: {
                Image(systemName:"backward.fill")
                    .font(.title2)
                    .foregroundColor(.primary)
            }
        
        
        )
        Spacer()
        Button(action: viewModel.playPause,
        label: {
            Image(systemName:  viewModel.playingState())
                    .font(.title2)
                    .foregroundColor(.primary)
        })
        Spacer()
        Button(action: viewModel.next, label: {
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

