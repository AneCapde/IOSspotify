//
//  PlaylistCardView.swift
//  music_player_app
//
//  Created by Michalina Janik on 07/11/2021.
//
import SwiftUI
import MediaPlayer

struct PlaylistCardView: View {
    
    let playlist: MPMediaItemCollection
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack {
             
                VStack(alignment: .leading) {
                    Text("\(playlist.value(forProperty: MPMediaPlaylistPropertyName) as? String ?? "NA")")
                    Text("\(playlist.value(forProperty: MPMediaPlaylistPropertyDescriptionText) as? String ?? "")")
                        .font(.caption)
                        .lineLimit(2) //maximum line that are occupied by this text
                }
                .foregroundColor(.white) //col of a text
                Spacer(minLength: 0)
                
            }
                
            .padding(10)
            .frame(height: 50)
            .background(BlurView(style: .systemUltraThinMaterial).cornerRadius(10, corners: [.bottomLeft, .bottomRight])
                )
            }
            .background(
                Image(uiImage: (playlist.representativeItem?.artwork?.image(at: CGSize(width:500, height: 100)) ?? UIImage(named: "music_background")) ?? UIImage())
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            )
            .aspectRatio(1.5, contentMode: .fit)
            .shadow(color: Color.black.opacity(0.05), radius: 2.5, x: 0, y: 2.5)
        }
        
}
