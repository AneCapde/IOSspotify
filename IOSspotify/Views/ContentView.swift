//
//  ContentView.swift
//  IOSspotifyAne
//
//  Created by Ane Capdevila on 17/11/2021.
//

import SwiftUI

struct ContentView: View {
   
   @ObservedObject var viewModel = ViewModelMusicPlayer()
    
    var body: some View {
        LogInSigInView(viewModel: viewModel)
        
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
