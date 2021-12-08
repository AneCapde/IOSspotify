//
//  BlurView.swift
//  music_player_app
//
//  Created by Michalina Janik on 07/11/2021.
//
import SwiftUI

public struct BlurView: UIViewRepresentable {
    let style: UIBlurEffect.Style
    
    public init(style: UIBlurEffect.Style = .regular){
        self.style = style
    }
    
    public func makeUIView(context: UIViewRepresentableContext<BlurView>) -> UIView {
        let view = UIView(frame: .zero)
        view.backgroundColor = .clear
        let blurEffect = UIBlurEffect(style: style)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.translatesAutoresizingMaskIntoConstraints = false
        view.insertSubview(blurView, at: 0)
        NSLayoutConstraint.activate([blurView.heightAnchor.constraint(equalTo: view.heightAnchor), blurView.widthAnchor.constraint(equalTo: view.widthAnchor),])
        return view
    }
    
    public func updateUIView(_ UIView: UIView, context: UIViewRepresentableContext<BlurView>) {}

}

public class Haptics {
    static private let shared = Haptics()
    
    private let softHammer = UIImpactFeedbackGenerator(style: .soft)
    private let hardHammer = UIImpactFeedbackGenerator(style: .light)
    private init(){
        softHammer.prepare()
        hardHammer.prepare()
    }
    
    public static func softRoll(){
        shared.softHammer.impactOccurred(intensity: 0.8)
    }
    
    public static func hardRoll(){
        shared.hardHammer.impactOccurred(intensity: 0.9)
    }
    
}
struct BlurView_Previews: PreviewProvider {
    static var previews: some View {
        BlurView()
    }
}
