//
//  User.swift
//  IOSspotifyAne
//
//  Created by Ane Capdevila on 17/11/2021.
//

import Foundation
import CoreData

struct User: Identifiable {
    
    var id:Int64 = 0
    var name: String = ""
    var password: String = ""
    var email:String = ""


    var people: [NSManagedObject] = []
    

//    func setPlaylist() {
//        let managedContext = PersistenceController.shared.container.viewContext
//        let entity = NSEntityDescription.entity(forEntityName: "Person", in: managedContext)!
//        let person = NSManagedObject(entity: entity, insertInto: managedContext)
//
//        person.setValue(playlist, forKey: "playlist")
//
//        do {
//            try managedContext.save()
//            //people.append(person)
//          } catch let error as NSError {
//            print("Could not save. \(error), \(error.userInfo)")
//        }
//    }


    

    func newUser(){
       
        let managedContext = PersistenceController.shared.container.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Person", in: managedContext)!
        let person = NSManagedObject(entity: entity, insertInto: managedContext)

        
        person.setValue(name, forKey: "name")
        person.setValue(email, forKey: "email")
        person.setValue(password, forKey: "password")
        //person.setValue(playlist, forKey: "playlist")
        
        do {
            try managedContext.save()
            //people.append(person)
          } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    


    mutating func logingIn() -> Bool{
        let managedContext = PersistenceController.shared.container.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Person")
        do {
            people = try managedContext.fetch(fetchRequest)
          } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        for person in people{

            if ( person.value(forKeyPath: "name") as? String == name &&  person.value(forKeyPath: "password") as? String == password){

                return true
            }
        }
        return false
    }

}




