//
//  TabBarMenu.swift
//  IOSspotify
//
//  Created by Michal Krukowski on 30/11/2021.
//

import SwiftUI

struct TabBarMenu: View {
    @ObservedObject var viewModel : ViewModelMusicPlayer
    @State var current=2;
    @ObservedObject var data : Data
    //minip properties
    @State  var expand = false
    @Namespace var animation
    
    
    var body: some View {
        
        ZStack(alignment: Alignment(horizontal: .center, vertical: .bottom), content:
                {
                    TabView(selection: $current){
                        
                        
                        
                        MenuView(data: data, viewModel: viewModel)
                            
                            //Text("Lib")
                            .tabItem {
                                Image(systemName: "rectangle.stack.fill")
                                
                                Text("Library") }.tag(1)
                        
                        
                        PlayListView(viewModel: viewModel, data: data)
                            //Text("Lib")
                            .tabItem {
                                Image(systemName: "tray.full.fill")
                                
                                Text("Playlist") }.tag(2)
                        
                        
                        
                        SearchView(data: data, currentDisplayArray: data.getAllSongs(), viewModel: viewModel, updateView: expand).tabItem {
                            Image(systemName: "magnifyingglass")
                            
                            Text("Search")
                            
                        }.tag(3)
                    }
                    
                    if viewModel.getSongName() != ""{
                        MiniPlayer(viewModel: viewModel, animation: animation)}
                    
                })
    }
}

struct TolBar_Previews: PreviewProvider {
    static var previews: some View {
        TabBarMenu(viewModel: ViewModelMusicPlayer(), data: Data())
    }
}
