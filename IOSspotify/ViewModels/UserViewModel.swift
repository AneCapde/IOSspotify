//
//  UserViewModel.swift
//  IOSspotifyAne
//
//  Created by Ane Capdevila on 17/11/2021.
//

import SwiftUI

class UserViewModel: ObservableObject{
    
    @Published var user =  User()
    private var db_manager = DB_manager()
    
    func newUser(){
        db_manager.newUser(nameValue: user.name, passwordValue: user.password, emailValue: user.email)
    }
    
    func logingIn() -> Bool{
        let list_users = db_manager.getUsers()
        print(list_users)
        for users in list_users {
            if (users.name == user.name && users.password == user.password){
                return true
            }
        }
        return false
    }
}
