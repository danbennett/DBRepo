//
//  CoreDataConnection.swift
//  DBRepo
//
//  Created by Daniel Bennett on 09/07/2016.
//  Copyright © 2016 Dan Bennett. All rights reserved.
//

import Foundation
import CoreData

public class CoreDataConnection : DatabaseConnection {
    
    private var storeName : String
    private var rootContext : NSManagedObjectContext!
    public var mainContext : NSManagedObjectContext!
    
    public required init(storeName: String) {
        self.storeName = storeName
    }
    
    public func setup() throws {
        try self.coordinator.addPersistentStoreWithType(NSSQLiteStoreType, configuration: nil, URL: self.storeUrl, options: self.storeOptions)
        repo_print("Successfully setup core data stack!", emoji: "👌")
        self.rootContext = self.createRootContext()
        self.mainContext = self.createMainContext(self.rootContext)
    }
    
    private func createRootContext() -> NSManagedObjectContext {
        let rootContext = NSManagedObjectContext (concurrencyType: .PrivateQueueConcurrencyType)
        rootContext.contextName = "root context"
        rootContext.persistentStoreCoordinator = self.coordinator
        rootContext.observeContextWillSave(rootContext)
        rootContext.observeContextDidChange(rootContext)
        rootContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        return rootContext
    }
    
    private func createMainContext(parentContext : NSManagedObjectContext) -> NSManagedObjectContext {
        let mainContext = NSManagedObjectContext (concurrencyType: .MainQueueConcurrencyType)
        mainContext.contextName = "main context"
        mainContext.parentContext = parentContext
        mainContext.observeContextWillSave(mainContext)
        return mainContext
    }
    
    //MARK:- Store options.
    private var storeOptions : [NSObject : AnyObject] = [
        NSMigratePersistentStoresAutomaticallyOption : true,
        NSInferMappingModelAutomaticallyOption : true,
        NSFileProtectionKey : NSFileProtectionComplete,
        NSSQLitePragmasOption : [
            "journal_mode" : "WAL"
        ]
    ]
    
    //MARK:- Coordinator.
    private lazy var coordinator : NSPersistentStoreCoordinator = {
        let psc = NSPersistentStoreCoordinator (managedObjectModel: self.managedObjectModel)
        return psc
    }()
    
    //MARK:- Model.
    private lazy var managedObjectModel : NSManagedObjectModel = {
        let mom = NSManagedObjectModel.mergedModelFromBundles(nil)
        return mom!
    }()
    
    //MARK:- URLs.
    private lazy var storeUrl : NSURL = {
        let documentsDirectory = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).last!
        let storeUrl : NSURL = (documentsDirectory.URLByAppendingPathComponent(self.storeName))
        return storeUrl
    }()
}
