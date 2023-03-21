//
//  CoreData.swift
//  OceanMakeMeHappy
//
//  Copyright (c) 2023 Minii All rights reserved.

import CoreData

class CoreData {
    enum Constants {
        static let modelName = "Folder"
    }
    
    static let shared = CoreData()
    
    var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: Constants.modelName)
        container.loadPersistentStores { _, error in
            if let error = error as? NSError? {
                debugPrint("Unresolved error \(error)")
            }
        }
        
        return container
    }()
    
    func saveContext() {
        if context.hasChanges {
            try? context.save()
        }
    }
}

extension CoreData {
    func fetchFolders() -> [Folder] {
        var folders = [Folder]()
        
        do {
            folders = try context.fetch(Folder.fetchRequest())
        } catch {
            debugPrint("fetch Error in Folders")
        }
        
        return folders
    }
}
