///
//  SignInView.swift
//  IOSspotifyAne
//
//  Created by Ane Capdevila on 17/11/2021.
//
import SwiftUI

struct SignInView: View {
    
    @ObservedObject var viewModel : ViewModelMusicPlayer
    
    @ObservedObject var data : Data
    let lightGreyColor = Color(red: 239.0/255.0, green: 243.0/255.0, blue: 244.0/255.0, opacity: 1.0)
    
    
    var body: some View {
        VStack {
            SignText()
            TextField("Username", text: $viewModel.userModel.name)
                .padding()
                .background(lightGreyColor)
                .cornerRadius(5.0)
                .padding()
            
            TextField("Email", text: $viewModel.userModel.email)
                .padding()
                .background(lightGreyColor)
                .cornerRadius(5.0)
                .padding()
            
            SecureField("Password", text: $viewModel.userModel.password)
                .padding()
                .background(lightGreyColor)
                .cornerRadius(5.0)
                .padding()
            
            NavigationLink(destination: TabBarMenu(viewModel: viewModel, data: data)) {
                Text("SIGN IN")}
                .font(.headline)
                .foregroundColor(.white)
                .padding()
                .frame(width: 220, height: 60)
                .background(Color.purple)
                .cornerRadius(15.0)
                .simultaneousGesture(TapGesture().onEnded{
                    viewModel.newUser()
                })
        }
    }
}

struct SignText: View {
    var body: some View {
        VStack {
            Text(" Sign in! ")
                .font(.largeTitle)
                .fontWeight(.semibold)
                .multilineTextAlignment(.center)
                .padding(.bottom, 20)
        }
    }
}
struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView(viewModel: ViewModelMusicPlayer(), data: Data())
    }
}
