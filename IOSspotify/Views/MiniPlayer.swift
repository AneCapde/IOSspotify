//
//  MiniPlayer.swift
//  IOSspotify
//
//  Created by Michal Krukowski on 30/11/2021.
//


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
                
                //FIGURE IT OUT USERDEFAULTS
                Image(viewModel.getAlbumImageName())
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
               
              //  Spacer(minLength: 0)

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
            
                HStack(spacing: 15){
                    
                    VStack{
                        HStack{
                            Text(timeString)
                            Spacer()
                            Text(viewModel.getSong().time)
                        }.padding(.horizontal)
                        
                        
//                    Slider(value: $time,
//                           in:0...100, onEditingChanged: {/*editing in isEditing = editing; */ editing in onChanged()})
//                            .onReceive(timer, perform: { _ in
//                                        self.updateTimer()})
                    
                    ProgressView(value: CGFloat(CMTimeGetSeconds(viewModel.getPlayer().currentTime())), total:CGFloat(CMTimeGetSeconds(viewModel.getPlayer().currentItem!.duration))).onReceive(timer, perform: { _ in
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
    func onChanged(){
        
       // timer.upstream.connect().cancel()
        let progress :Float = Float(time / 100)
        print(progress)
        let total: CMTime? = viewModel.getPlayer().currentItem?.asset.duration
        
        let sec = Float(CMTimeGetSeconds(total!)) * progress
        print(sec)
        
        viewModel.updateTime(to: Float64(sec))
        //timer = Timer.publish(every: 1, on: .current, in:.default).autoconnect()
        
        
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
            timeString = String(createTime(Int(sec)))
            
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
    func createTime(_ value: Int) -> String {
        let mm = value/60
        var ss = value
        if mm >= 1{ ss-=mm*60 }
        if ss < 10{ return String(String(mm) + ":" + "0" + String(ss)) }
        return String(String(mm) + ":" + String(ss))
        
    }
}

struct BarView: UIViewRepresentable{
    

    
    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<BarView>) {
    }
    
    func makeUIView(context: Context) -> UIView {
        return ProgresBar(frame: .zero)
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

class ProgresBar: UIView{
    

    private let playerLayer = AVPlayerLayer()
    override init(frame: CGRect) {
        super.init(frame: frame)
       
        
//        muiscLenthLabel.rightAnchor.constraint(equalTo: rightAnchor).isActive=true
//        muiscLenthLabel.bottomAnchor.constraint(equalTo: bottomAnchor,constant: 60).isActive=true
//        muiscLenthLabel.heightAnchor.constraint(equalToConstant: 30).isActive=true
//
        
        
     }
    
    
     required init?(coder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
     }
     override func layoutSubviews() {
       super.layoutSubviews()
       playerLayer.frame = bounds
     }
    

        
        let muiscLenthLabel: UILabel = {
            let label = UILabel()
            label.text = "00:00"
            label.textColor = .purple
            
            return label
            
        }()
    
    let controlsConteinerView: UIView={
       let view = UIView()
        view.backgroundColor=UIColor(white: 0, alpha: 1)
        return view
        
        
    }()
     
        
   // }
}

//struct MiniPlayerPreview: PreviewProvider {
//
//
//
//
//    static var previews: some View {
//        MiniPlayer( viewModel: ViewModelMusicPlayer(), animation: <#Namespace.ID#>)
//    }
//}
//
