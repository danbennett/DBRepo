//
//  NSManagedObjectContext+RepoLifetimeType.swift
//  DBRepo
//
//  Created by Daniel Bennett on 09/07/2016.
//  Copyright © 2016 Dan Bennett. All rights reserved.
//

import Foundation
import CoreData

extension NSManagedObjectContext : RepoLifetimeType {
    
    public func addEntity<T : EntityType>(type : T.Type) throws -> T {
        guard let managedObject = NSEntityDescription.insertNewObjectForEntityForName(type.className, inManagedObjectContext: self) as? T else {
            throw NSError(domain: "co.uk.danbennett", code: 8001, userInfo: [NSLocalizedDescriptionKey : "No entity matches name \(type.className)"])
        }
        return managedObject
    }
    
    public func removeEntity<T : EntityType>(entity : T) throws {
        guard let managedObject = entity as? NSManagedObject else {
            throw NSError(domain: "co.uk.danbennett", code: 8001, userInfo: [NSLocalizedDescriptionKey : "None NSManagedObject used in context \(entity)"])
        }
        self.deleteObject(managedObject)
    }
    
}