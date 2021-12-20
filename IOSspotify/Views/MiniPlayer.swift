import SwiftUI
import AVFoundation

struct MiniPlayer: View {
    
    @ObservedObject var viewModel : ViewModelMusicPlayer
    
    var animation: Namespace.ID
    var height = UIScreen.main.bounds.height / 3
    var lastListenedSong = UserDefaults.standard.string(forKey: "lastSong")
    var safeArea = UIApplication.shared.windows.first?.safeAreaInsets
    
    
    @State var timer = Timer.publish(every: 0.1, on: .current, in:.default).autoconnect()
    @State var volume: CGFloat = 0.5
    @State var isEditing = false
    @State var timeString = "0:00"
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
                
                
                Image(uiImage: viewModel.getAlbumImageName()) //?? Image("image_1")
                    .resizable()
                    .aspectRatio(contentMode:   .fill)
                    .frame(width: viewModel.expand() ? height : 55 , height: viewModel.expand() ? height :55)
                    .cornerRadius(15)
                
                if !viewModel.expand(){
                    Text(viewModel.lastListenedSong ?? "FireWorks")
                        .font(  .title3)
                        .fontWeight(.thin)
                        .matchedGeometryEffect(id: "Label", in: animation)
                    
                }
                
                Spacer(minLength:  /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/)
                
                if !viewModel.expand(){
                    ButtonsView(viewModel: viewModel)
                }
            }
            .padding(.horizontal)
            
            VStack(spacing: 15){
                
                //Spacer(minLength: 0)
                HStack{
                    if viewModel.expand() {
                        Text(viewModel.returnCurrentSong()?.name ?? "NA")
                            .font(.title2)
                            .foregroundColor(.primary)
                            .fontWeight(.bold)
                            .matchedGeometryEffect(id: "Label", in: animation)
                        
                    }
                }
                .padding(.top)
                
                HStack{ButtonsView(viewModel: viewModel)}
                
                
                HStack(spacing: 15){
                    
                    VStack{
                        HStack{
                            Text(timeString)
                            Spacer()
                            Text(MiniPlayer.createTime(Int(viewModel.getSong().time!)))
                        }.padding(.horizontal)
                        
                        
                        ProgressView(value: CGFloat(CMTimeGetSeconds(viewModel.getPlayer().currentTime())), total:CGFloat(CMTimeGetSeconds(viewModel.getPlayer().currentItem?.duration ?? CMTimeMakeWithSeconds(Float64(20), preferredTimescale: 10)))).onReceive(timer, perform: { _ in
                                                                                                                                                                                                                                                                    self.updateTimer()}).padding(.horizontal).accentColor(.purple)
                            .scaleEffect(x: 1, y: 1.3, anchor: .center)
                    }
                    
                    // Text(viewModel.getSong().time)
                    //BarView()
                }.padding()
                
                Spacer(minLength: 0)
                
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
        if (viewModel.expand() == true && viewModel.isPlaying()){
            let currentTime: CMTime = viewModel.getPlayer().currentTime()
            let total: CMTime? = viewModel.getPlayer().currentItem?.asset.duration
            
            let sec = CMTimeGetSeconds(currentTime)
            timeString = String(MiniPlayer.createTime(Int(sec)))
            
            let progress: Float = Float(CMTimeGetSeconds(currentTime))/Float(CMTimeGetSeconds(total!))
            
            if progress >= 0.98 {
                
                viewModel.next()
                return
            }
            
            withAnimation(Animation.linear(duration:0.1)){
                self.time = CGFloat(progress)
            }
        }
    }
    
    static func createTime(_ value: Int) -> String {
        let mm = value/60
        var ss = value
        if mm >= 1{ ss-=mm*60 }
        if ss < 10{ return String(String(mm) + ":" + "0" + String(ss)) }
        return String(String(mm) + ":" + String(ss))
    }
}
struct ButtonsView: View{
    
    @ObservedObject var viewModel : ViewModelMusicPlayer
    
    var body: some View{
        Spacer()
        Button(action: {
            viewModel.previous()
            viewModel.lastListenedSong = viewModel.returnCurrentSong()?.name
            viewModel.lastListenedAlbum = viewModel.returnCurrentAlbum().name
            UserDefaults.standard.set(viewModel.lastListenedSong, forKey: "lastSong")
            UserDefaults.standard.set(viewModel.lastListenedAlbum, forKey: "lastAlbum")
        }
        , label: {
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
        Button(action: {
            viewModel.next()
            viewModel.lastListenedSong = viewModel.returnCurrentSong()?.name
            viewModel.lastListenedAlbum = viewModel.returnCurrentAlbum().name
            UserDefaults.standard.set(viewModel.lastListenedSong, forKey: "lastSong")
            UserDefaults.standard.set(viewModel.lastListenedAlbum, forKey: "lastAlbum")
        }
        , label: {
            Image(systemName:"forward.fill")
                .font(.title2)
                .foregroundColor(.primary)
            
        })
        Spacer()
    }
    
}
