//
//  TabBarMenu.swift
//  IOSspotify
//
//  Created by Michal Krukowski on 30/11/2021.
//

import SwiftUI

struct TabBarMenu: View {
    @State var current=1;
    @StateObject var data = Data()
    
    var body: some View {
        
        ZStack(alignment: Alignment(horizontal: .center, vertical: .bottom), content:
                {
            
                    
                    
                    TabView(selection: $current){
                                
                        MenuView(data: data)
                                    //Text("Lib")
                                    .tabItem {
                                    Image(systemName: "rectangle.stack.fill")
                                    
                                    Text("Library") }.tag(1)
                               
                                
                                Text("Search").tabItem {
                                    Image(systemName: "magnifyingglass")
                                    
                                    Text("Search")
                                    
                                    }.tag(2)
                            }
                    MiniPlayer()
                    
                    })
        
    }
}

struct TolBar_Previews: PreviewProvider {
    static var previews: some View {
        TabBarMenu()
    }
}
