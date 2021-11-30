//
//  LogInView.swift
//  IOSspotifyAne
//
//  Created by Ane Capdevila on 17/11/2021.
//

import SwiftUI

struct LogInView: View {
    @State private var alertisPresented = false
    @State private var credentials = false
    @ObservedObject var userViewModel: UserViewModel
    @StateObject var data = Data()
    let lightGreyColor = Color(red: 239.0/255.0, green: 243.0/255.0, blue: 244.0/255.0, opacity: 1.0)
    
    
    var body: some View {
        VStack {
            LoginText()
            TextField("Username", text: $userViewModel.user.name)
                .padding()
                .background(lightGreyColor)
                .cornerRadius(5.0)
                .padding()
            
            SecureField("Password", text: $userViewModel.user.password)
                .padding()
                .background(lightGreyColor)
                .cornerRadius(5.0)
                .padding()
            
            NavigationLink(destination: MenuView(data: data)) {
            Text("LOG IN")}
                .font(.headline)
                .foregroundColor(.white)
                .padding()
                .frame(width: 220, height: 60)
                .background(Color.purple)
                .cornerRadius(1.0)
                .alert(isPresented: $alertisPresented, content: {
                    Alert(title: Text("ERROR!"), message: Text("Your enter the wrong password!"), dismissButton: .default(Text("Try Again!")))
                })
                .simultaneousGesture(TapGesture().onEnded{
                                credentials = logIn()
                                })
        }
    }
    func logIn() -> Bool{
        if (!userViewModel.logingIn()){
            alertisPresented = true
        }
        return userViewModel.logingIn()
    }
}

struct LoginText: View {
    var body: some View {
        VStack {
            Text(" Log in! ")
                .font(.largeTitle)
                .fontWeight(.semibold)
                .multilineTextAlignment(.center)
                .padding(.bottom, 20)
        }
    }
}
struct LogInView_Previews: PreviewProvider {
    static var previews: some View {
        LogInView(userViewModel: UserViewModel())
    }
}
