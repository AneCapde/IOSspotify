//
//  DB_manager.swift
//  IOSspotifyAne
//
//  Created by Ane Capdevila on 17/11/2021.
//

import Foundation

import SQLite

class DB_manager {

    //sqlite instace
    private var db: Connection!
    
    //table instance
    private var users: Table!
    
    //colmuns intances of tables
    private var id: Expression<Int64>!
    private var name: Expression<String>!
    private var password: Expression<String>!
    private var email: Expression<String>!
    
    
    
    //constructor of the class
    init() {
        
        //exception handeling
        do{
            let path: String = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first ?? ""
            
            //creating database connection
            db = try Connection("\(path)/my_users.sqlite3")
            
            //creating table object
            users = Table("users")
            // create instances of each column
            id = Expression<Int64>("id")
            name = Expression<String>("name")
            password = Expression<String>("password")
            email = Expression<String>("email")
            
            
            //check if yje user´s table is already created
            if (!UserDefaults.standard.bool(forKey: "is_db_created")){
                //if not then create the table
                try db.run(users.create{(t) in
                    t.column(id, primaryKey: true)
                    t.column(name)
                    t.column(password)
                    t.column(email)
                })
            }
            //set the value to true, so it will not attempt to create the table again
            UserDefaults.standard.set(true, forKey: "is_db_created")
        }
        catch{
            //show error message if any
            print(error.localizedDescription)
        }
    }
    
    public func newUser(nameValue: String, passwordValue: String, emailValue: String) {
        do {
            try db.run(users.insert(name <- nameValue, password <- passwordValue, email <- emailValue))
        } catch {
            print(error.localizedDescription)
        }
    }
    // return array of user models
    public func getUsers() -> [User] {
         
        // create empty array
        var userModels: [User] = []
     
        // get all users in descending order
        users = users.order(id.desc)
     
        // exception handling
        do {
     
            // loop through all users
            for user in try db.prepare(users) {
     
                // create new model in each loop iteration
                var userModel: User = User()
     
                // set values in model from database
                userModel.id = user[id]
                userModel.name = user[name]
                userModel.email = user[email]
                userModel.password = user[password]
     
                // append in new array
                userModels.append(userModel)
            }
        } catch {
            print(error.localizedDescription)
        }
     
        // return array
        return userModels
    }
    public func deleteUsers() {
        do {
            // get user using ID
            let user: Table = users
             
            // run the delete query
            try db.run(user.delete())
        } catch {
            print(error.localizedDescription)
        }
    }
    
}
