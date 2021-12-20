//
//  LogInView.swift
//  IOSspotifyAne
//
//  Created by Ane Capdevila on 17/11/2021.
//
import SwiftUI

struct LogInView: View {
    @State private var alertisPresented = false
    @State private var credentials = false
    @ObservedObject var data : Data
    @ObservedObject var viewModel : ViewModelMusicPlayer
    
    let lightGreyColor = Color(red: 239.0/255.0, green: 243.0/255.0, blue: 244.0/255.0, opacity: 1.0)
    
    
    var body: some View {
        VStack {
            LoginText()
            TextField("Username", text: $viewModel.userModel.name)
                .padding()
                .background(lightGreyColor)
                .cornerRadius(5.0)
                .padding()
            
            SecureField("Password", text: $viewModel.userModel.password)
                .padding()
                .background(lightGreyColor)
                .cornerRadius(5.0)
                .padding()
            
            NavigationLink(destination: TabBarMenu(viewModel: viewModel, data: data)) {
                Text("LOG IN")}
                .font(.headline)
                .foregroundColor(.white)
                .padding()
                .frame(width: 220, height: 60)
                .background(Color.purple)
                .cornerRadius(15.0)
                .alert(isPresented: $alertisPresented, content: {
                    Alert(title: Text("ERROR!"), message: Text("Your enter the wrong password!"), dismissButton: .default(Text("Try Again!")))
                })
                .simultaneousGesture(TapGesture().onEnded{
                    
                    credentials = logIn()
                    let song = getSong(songName: viewModel.lastListenedSong ?? "Fireworks")
                    let album = getAlbum(song: song)
                    viewModel.updateCurrentAlbum(album: album)
                    viewModel.updateCurrentSong(song: song)
                    //viewModel.createPlayer()
                })
                .navigationViewStyle(StackNavigationViewStyle.init())
        }
    }
    func getAlbum(song: Song) -> Album {
        for album in data.getAllAlbums(){
            if album.songs.contains(song){
                return album
            }
        }
        return Album()
    }
    func getSong(songName: String)-> Song {
        for song in data.getAllSongs(){
            if song.name == songName{
                return song
            }
        }
        return Song(name: "We Rock", time: 160.5, fileName: "song2")
    }
    
    func logIn() -> Bool{
        if (!viewModel.logingIn()){
            alertisPresented = true
        }
        return viewModel.logingIn()
    }
}

struct LoginText: View {
    var body: some View {
        VStack {
            Text(" Log in! ")
                .font(.largeTitle)
                .fontWeight(.semibold)
                .multilineTextAlignment(.center)
                .padding(.bottom, 20)
        }
    }
}
//struct LogInView_Previews: PreviewProvider {
//    static var previews: some View {
//        LogInView(viewModel: ViewModelMusicPlayel())
//    }
//}
