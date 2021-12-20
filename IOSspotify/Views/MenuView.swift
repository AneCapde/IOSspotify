//
//  MenuView.swift
//  IOSspotifyAne
//
//  Created by Ane Capdevila on 17/11/2021.
//
import SwiftUI

struct MenuView: View {
    
    @State private var currentAlbum : Album?
    @ObservedObject var data : Data
    @ObservedObject var viewModel : ViewModelMusicPlayer
    @State var updateView = false
    
    var body: some View {
        ScrollView{
            ScrollView(.horizontal, showsIndicators: false, content: {
                LazyHStack {
                    ForEach(self.data.getAllAlbums(), id:\.self, content: {
                        
                        album in
                        AlbumArt(album: album, isWithText: true).onTapGesture{
                            self.currentAlbum = album
                        }
                    })
                }
            })
            
            LazyVStack {
                ForEach((self.currentAlbum?.songs ?? data.getAllAlbums().first?.songs)! , id:\.self, content: {
                    song in SongCell(album: currentAlbum ?? data.getAllAlbums().first!, song: song, data: data, updateView: $updateView,  viewModel: viewModel)
                })
            }
        }
        // TabBarMenu()
    }
}
struct AlbumArt: View {
    var album : Album
    var isWithText : Bool
    var body: some View {
        ZStack(alignment: .bottom, content: {
            Image(uiImage: album.image)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 150, height: 200, alignment: .center)
            if isWithText == true {
                ZStack{
                    Blur(style: .dark)
                    Text(album.name!).foregroundColor(.white)
                }.frame(height: 60, alignment: .center)
            }
        }).frame(width: 170, height: 200, alignment: .center)
        .clipped().cornerRadius(20).shadow(radius: 10).padding(20)
    }
}

struct SongCell: View {
    var album : Album
    var song : Song
    @ObservedObject var data : Data
    @State  var showPopUp: Bool = false
    @Binding var updateView: Bool
    @ObservedObject var viewModel : ViewModelMusicPlayer
    @Namespace var animation
    
    var body: some View {
       
        
        HStack{
            
            Image(uiImage: song.image!)
                .resizable()
                .aspectRatio(contentMode:   .fill)
                .frame(width: 55, height: 55, alignment: .center)
                .aspectRatio(contentMode:   .fill)
                .cornerRadius(15)
            
            Text(song.name!).bold()
            Spacer()
            Text(MiniPlayer.createTime(Int(song.time!)))
        }
        .padding(20)
        .onTapGesture {
            updateUserDefaults()
            // MiniPlayer(animation: Namespace.ID, expand: false, viewModel: viewModel)
        }
        //cONTEXT MENU
        .contextMenu(ContextMenu(menuItems: {
            Button( action: {
                data.addToPlaylist(song: song, playlistName: "favourites");
                updateView.toggle()
                data.updView()
            }, label: {
                Label("add to favourites", systemImage: "heart.fill")
            })
            
            Button( action: {
                data.deleteFromPlaylist(song: song, playlistName: "favourites");
                updateView.toggle()
                data.updView()
                
            }, label: {
                Label("remove from favourites", systemImage: "minus")
            })
            
            Button{
                showPopUp = true;
                
            } label: {
                Label("get Info", systemImage: "eye")
            }
        }))
      
            NavigationLink(
                destination: PopUpWindow(title: "Info", message: viewModel.displayInfo(song: song), buttonText: "OK", show: $showPopUp).aspectRatio( contentMode: .fill) ,
                isActive: $showPopUp ,         label: {
                    
                }).navigationViewStyle(StackNavigationViewStyle.init())

        
//        displayInfo(song: song).aspectRatio(CGSize(width: UIScreen.main.bounds.width, height: 20), contentMode: .fit)
                
            
        
    }
    
    func displayInfo(song: Song) -> some View{
        PopUpWindow(title: "Info", message: viewModel.displayInfo(song: song), buttonText: "OK", show: $showPopUp)
    }
    
    

    
    func updateUserDefaults(){
        viewModel.updateCurrentAlbum(album: album)
        viewModel.updateCurrentSong(song: song)
        viewModel.playSong()
        viewModel.lastListenedSong = viewModel.returnCurrentSong()?.name
        viewModel.lastListenedAlbum = viewModel.returnCurrentAlbum().name
        UserDefaults.standard.set(viewModel.lastListenedSong, forKey: "lastSong")
        UserDefaults.standard.set(viewModel.lastListenedAlbum, forKey: "lastAlbum")
    }
}

struct PopUpWindow: View {
    var title: String
    var message: String
    var buttonText: String
    @Binding var show: Bool

    var body: some View {
       
        ZStack {
            if show {
                
                Image("info_bgd")
                    .resizable()
                    .opacity(0.2)
                    .blur(radius: 2.0)
                   
                // PopUp Window
                VStack(alignment: .center) {
                    Text(title)
                        .multilineTextAlignment(.center)
                        .frame(maxWidth: .infinity)
                        .font(Font.system(size: 26, weight: .semibold))
                        .foregroundColor(Color.gray)
                        

                    Text(message)
                        .multilineTextAlignment(.center)
                        .font(Font.system(size: 20, weight: .semibold))
                        .padding(EdgeInsets(top: 20, leading: 25, bottom: 20, trailing: 25))
                        .foregroundColor(Color.gray)

                    Button(action: {
                        // Dismiss the PopUp
                        withAnimation(.linear(duration: 0.3)) {
                            show = false
                        }
                    }, label: {
                        Text(buttonText)
                            .multilineTextAlignment(.center)
                            .frame(maxWidth: .infinity)
                            .frame(height: 20, alignment: .center)
                            .font(Font.system(size: 26, weight: .semibold))
                            .foregroundColor(Color.gray)
                    }).buttonStyle(PlainButtonStyle())
                }.padding()
                
              
            }
            
        }
    }
}

struct PopUpWindow_Previews: PreviewProvider {
    @State static public var a = true
    static var previews: some View {
        PopUpWindow(title:"a", message:"bb", buttonText:"ok", show: $a )
    }
}
