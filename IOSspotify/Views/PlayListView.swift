//
//  PlayListView.swift
//  IOSspotify
//
//  Created by Ane Capdevila on 13/12/2021.
//

import SwiftUI

struct PlayListView: View {
    @ObservedObject var viewModel : ViewModelMusicPlayer
    @ObservedObject var data : Data
    @State var isShowing = false
    @State var text = ""
    
    var body: some View {
        ScrollView{
            VStack(spacing: 18){
                HStack{
                    Text("Playlists")
                        .font(.largeTitle)
                        .fontWeight(.heavy)
                        .foregroundColor(.primary)
                    
                    Spacer(minLength: 0)
                    
                }.padding(20)
                
                
                HStack{
                    
                    Image(systemName: "square.and.pencil")
                        .onTapGesture {
                            self.isShowing.toggle()
                        }
                        
                        .font(.system(size: 56.0))
                        //.resizable()
                        .aspectRatio(contentMode:   .fill)
                        .frame(width: 55, height: 55, alignment: .center)
                        .aspectRatio(contentMode:   .fill)
                        .cornerRadius(15)
                    Text("Add new Playlist").bold()
                    Spacer()
                }.padding(15)
                
                VStack{
                    ForEach(data.getAllPlaylists(), id:\.self, content: {
                        play in PlayList(playlist: play, data: data, viewModel: viewModel)
                    })
                }.padding(15)
            }
        }
        .textFieldAlert(isShowing: $isShowing, text: $text, title: "Enter the title of the playlist", data : data)
    }
}

extension View {
    func textFieldAlert(isShowing: Binding<Bool>,
                        text: Binding<String>,
                        title: String,
                        data: Data
                       
    ) -> some View {
        TextFieldAlert(isShowing: isShowing,
                       text: text,
                       data: data,
                       presenting: self,
                       title: title)
    }
    
}
struct TextFieldAlert<Presenting>: View where Presenting: View {
    
    
    @Binding var isShowing: Bool
    @Binding var text: String
    @ObservedObject var data : Data
    let presenting: Presenting
    let title: String
    
    
    var body: some View {
        GeometryReader { (deviceSize: GeometryProxy) in
            ZStack {
                self.presenting
                    .disabled(isShowing)
                VStack {
                    Text(self.title)
                    TextField("Name", text: self.$text)
                    
                    
                    HStack {
                        Button(action: {
                            withAnimation {
                                data.addPlaylist(name: text, songs: [])
                                text = ""
                                self.isShowing.toggle()
                            }
                        }) {
                            Text("Ok")
                        }.foregroundColor(.white)
                        .padding()
                        .frame(width: 220, height: 60)
                        .background(Color.purple)
                        .cornerRadius(15.0)
                    }
                }
                .padding()
                .background(Color.white)
                .frame(
                    width: deviceSize.size.width*0.7,
                    height: deviceSize.size.height*0.7
                )
                .shadow(radius: 1)
                .opacity(self.isShowing ? 1 : 0)
            }
        }
    }
    
}

struct PlayList: View {
    var playlist : PlaylistModel
    @ObservedObject var data : Data
    
    
    @ObservedObject var viewModel : ViewModelMusicPlayer
    var body: some View {
        HStack{
            Image("cover_1")
                .resizable()
                .aspectRatio(contentMode:   .fill)
                .frame(width: 55, height: 55, alignment: .center)
                .aspectRatio(contentMode:   .fill)
                .cornerRadius(15)
            
            
            NavigationLink(destination: PlaylistDisplay(playlist: data.getPlaylist(name: playlist.name)!, data: data, viewModel: viewModel)){
                Text(playlist.name).bold()
                    .foregroundColor(.black)
            }
            Spacer()
            Image(systemName:  "play.fill")
        }
        .padding(20)
        
    }
}



//struct PlayListView_Previews: PreviewProvider {
//    static var previews: some View {
//        PlayListView(viewModel: <#ViewModelMusicPlayer#>())
//    }
//}
