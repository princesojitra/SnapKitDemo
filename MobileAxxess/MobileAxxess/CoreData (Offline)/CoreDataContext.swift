//
//  CoreDataContext.swift
//  MVVM Archiecture
//
//  Created by Prince Sojitra on 12/07/20.
//  Copyright © 2020 Prince Sojitra. All rights reserved.
//

import Foundation
import CoreData

class CoreDataContext {
    
    // coredata model constant
    static let datamodelName = "MobileAxxess"
    static let storeType = "sqlite"
    
    // set persistancecontainer
    static let persistentContainer = NSPersistentContainer(name: datamodelName)
    static let url: URL = {
        let url = FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask)[0].appendingPathComponent("\(datamodelName).\(storeType)")
        
        assert(FileManager.default.fileExists(atPath: url.path))
        print("Persistant Store:", url)
        return url
    }()
    
    // load persistant stores
    static func loadStores() {
        persistentContainer.loadPersistentStores(completionHandler: { (nsPersistentStoreDescription, error) in
            guard let error = error else {
                return
            }
            fatalError(error.localizedDescription)
        })
    }
    
    // delete and rebulid persistant stores
    static func deleteAndRebuild() {
        try! persistentContainer.persistentStoreCoordinator.destroyPersistentStore(at: url, ofType: storeType, options: nil)
        
        loadStores()
    }
    
    // save changes to context
    static func saveContext() {
        if self.persistentContainer.viewContext.hasChanges {
            do {
                try self.persistentContainer.viewContext.save()
            } catch {
                print("An error occurred while saving: \(error)")
            }
        }
    }
}
