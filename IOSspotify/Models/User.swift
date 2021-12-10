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
    var lastListenedSong: String?
    var people: [NSManagedObject] = []
    
    
    
    
    fileprivate func saveCoreData(_ managedContext: NSManagedObjectContext) {
        do {
            try managedContext.save()
            //people.append(person)
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    func newUser(){
       
        let managedContext = PersistenceController.shared.container.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Person", in: managedContext)!
        let person = NSManagedObject(entity: entity, insertInto: managedContext)

        person.setValue(name, forKey: "name")
        person.setValue(email, forKey: "email")
        person.setValue(password, forKey: "password")
        person.setValue(lastListenedSong, forKey: "lastListenedSong")
        
        saveCoreData(managedContext)
    }
    
    mutating func updateLastlistenedSong(){
        let managedContext = PersistenceController.shared.container.viewContext
        let person = currentUser()
        
        person.setValue(lastListenedSong, forKey: "lastListenedSong")
        saveCoreData(managedContext)
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
            if (person.value(forKeyPath: "name") as? String == name &&  person.value(forKeyPath: "password") as? String == password){
                return true
            }
        }
        return false
    }
    
    
    mutating func currentUser() -> NSManagedObject {
        var currentUser = NSManagedObject()
        for person in people{
            if (person.value(forKeyPath: "name") as? String == name &&  person.value(forKeyPath: "password") as? String == password){
                currentUser = person
            }
        }
        return currentUser
    }
}






