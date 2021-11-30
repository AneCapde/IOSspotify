//
//  IOSspotifyApp.swift
//  IOSspotify
//
//  Created by Ane Capdevila on 10/11/2021.
//
import SwiftUI
import StoreKit
import MediaPlayer

@main
struct IOSspotifyApp: App {
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
    
    
//    @Environment(\.scenePhase) var scenePhase
//
//    init(){
//        updateSongs()
//    }
//
//    var body: some Scene {
//        WindowGroup {
//            ContentView()
//                .onChange(of: scenePhase, perform: { value in
//                    if value == .active {
//                       updateSongs()
//                    }
//                })
//        }
//    }
//
//
//    func updateSongs(){
//        SKCloudServiceController.requestAuthorization {
//            status in
//            if status == .authorized{
//
//                let songsQuery = MPMediaQuery.songs()
//                if let songs = songsQuery.items{
//                    let desc = NSSortDescriptor(key: MPMediaItemPropertyLastPlayedDate, ascending: false)
//                    let sortedSongs = NSArray(array: songs).sortedArray(using: [desc])
//
//                    ModelMusicPlayer.singletonMusicPlayer.librarySongs = sortedSongs as! [MPMediaItem]
//                }
//
//                let playlistQuery = MPMediaQuery.playlists()
//                if let playlists = playlistQuery.collections {
//
//                    ModelMusicPlayer.singletonMusicPlayer.playlists = playlists
//                }
//            }
//        }
//
//    }
}
