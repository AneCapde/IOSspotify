//
//  Blur.swift
//  IOSspotifyAne
//
//  Created by Ane Capdevila on 19/11/2021.
//

import Foundation

import SwiftUI

struct Blur: UIViewRepresentable {
    var style: UIBlurEffect.Style = .systemChromeMaterial
    func makeUIView(context: Context) -> UIVisualEffectView {
        
        return UIVisualEffectView(effect: UIBlurEffect(style: style))
    }
    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
        uiView.effect = UIBlurEffect(style: style)
    }
}
