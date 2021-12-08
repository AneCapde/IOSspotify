//
//  UserViewModel.swift
//  IOSspotifyAne
//
//  Created by Ane Capdevila on 17/11/2021.
//

import SwiftUI
import CoreData

class UserViewModel: ObservableObject{
    
    @Published var userModel = User()
    var people: [NSManagedObject] = []
    
    init() {
    
    }
    
    func newUser(){
       
        let managedContext = PersistenceController.shared.container.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Person", in: managedContext)!
        let person = NSManagedObject(entity: entity, insertInto: managedContext)
        
        person.setValue(userModel.name, forKey: "name")
        person.setValue(userModel.email, forKey: "email")
        person.setValue(userModel.password, forKey: "password")
        
        do {
            try managedContext.save()
            //people.append(person)
          } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    func logingIn() -> Bool{
        let managedContext = PersistenceController.shared.container.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Person")
        do {
            people = try managedContext.fetch(fetchRequest)
          } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        for person in people{
            if ( person.value(forKeyPath: "name") as? String == userModel.name &&  person.value(forKeyPath: "password") as? String == userModel.password){
                return true
            }
        }
        return false
    }
}
