//
//  CoreDataManager.swift
//  HackathonDevcamp
//
//  Created by Maria Berliana on 08/12/23.
//

import Foundation
import CoreData

class CoreDataManager{
    let persistentStoreContainer: NSPersistentContainer
    static let shared = CoreDataManager()
    
    private init(){
        persistentStoreContainer = NSPersistentContainer(name: "GoSplit")
        persistentStoreContainer.loadPersistentStores{ description, error in
            if let error = error{
                fatalError("unable to initialize \(error)")
                
            }

        }
        
    }
    
    
}

