//
//  ContentView.swift
//  IOSspotifyAne
//
//  Created by Ane Capdevila on 17/11/2021.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var viewModel = ViewModelMusicPlayer()
    @StateObject var data = Data()
    
    var body: some View {
        LogInSigInView(viewModel: viewModel, data: data)
        
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
