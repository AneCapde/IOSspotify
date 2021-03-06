//
//  SongCardView.swift
//  IOSspotify
//
//  Created by Michalina Janik on 08/12/2021.
//

import SwiftUI
import MediaPlayer
struct SongCardView: View {
    
    let song: MPMediaItem
    
    var body: some View {
        HStack{
            Image(uiImage: (song.artwork?.image(at: CGSize(width: 500, height: 500))
                                ?? UIImage(named: "music_background")) ?? UIImage())
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 120, height: 120)
                .clipShape(RoundedRectangle(cornerRadius: 10))
            
            VStack(alignment: .leading){
                Text("\(song.title ?? "NA" )")
                Text("\(song.artist ?? "NA" )")
                    .font(.caption)
            }
            
            Spacer()
        }
        .padding(10)
        
    }
}


