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
        let persistenceController = PersistenceController.shared
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
