//
//  LogInSigInView.swift
//  IOSspotifyAne
//
//  Created by Ane Capdevila on 17/11/2021.
//

import SwiftUI

struct LogInSigInView: View {
    @StateObject var userViewModel = UserViewModel()
    var body: some View {
        NavigationView{
            VStack {
                WelcomeText()
                ImageIcon()
                NavigationLink(destination: LogInView(userViewModel: userViewModel)) {
                Text("LOG IN")}
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(width: 220, height: 60)
                    .background(Color.purple)
                    .cornerRadius(1.0)
                    
                NavigationLink(destination: SignInView(userViewModel: userViewModel)) {
                Text("SIGN IN")}
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(width: 220, height: 60)
                    .background(Color.purple)
                    .cornerRadius(1.0)
                
                
            }
        }
    }

}

struct WelcomeText: View {
    var body: some View {
        VStack {
            Text("Welcome!")
                .font(.largeTitle)
                .fontWeight(.semibold)
                .multilineTextAlignment(.center)
                .padding()
        }
    }
}
struct ImageIcon: View {
    var body: some View {
        VStack {
            Image("start_image")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 150.0, height: 150.0, alignment: .center)
                .clipShape(Circle())
                .padding()
        }
    }
}



struct LogInSigInView_Previews: PreviewProvider {
    static var previews: some View {
        LogInSigInView()
    }
}
