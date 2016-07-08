//
//  NSManagedObjectContext+Notifications.swift
//  DBRepo
//
//  Created by Daniel Bennett on 09/07/2016.
//  Copyright © 2016 Dan Bennett. All rights reserved.
//

import Foundation
import CoreData

private extension Selector {
    static let contextWillSave = #selector(NSManagedObjectContext.contextWillSave(_:))
    static let contextDidChange = #selector(NSManagedObjectContext.contextDidChange(_:))
}

extension NSManagedObjectContext {
    
    func observeContextWillSave (context : NSManagedObjectContext) {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: .contextWillSave, name: NSManagedObjectContextWillSaveNotification, object: context)
    }
    
    func observeContextDidChange (context : NSManagedObjectContext) {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: .contextDidChange, name: NSManagedObjectContextObjectsDidChangeNotification, object: context)
    }
    
    //MARK:- Handlers.
    func contextWillSave(notification : NSNotification) {
        if let context = notification.object as? NSManagedObjectContext {
            let insertedObjects = context.insertedObjects
            if insertedObjects.count > 0 {
                do {
                    try context.obtainPermanentIDsForObjects(Array(insertedObjects))
                    repo_print("Adding \(Array(insertedObjects).count) objects to context", emoji: "😁")
                } catch {
                    let contextError = error as NSError
                    repo_print("There was a problem obtaining IDs for objects \(contextError.userInfo)", emoji: "😭")
                }
            }
        }
    }
    
    func contextDidChange(notification : NSNotification) {
        //
    }
}
