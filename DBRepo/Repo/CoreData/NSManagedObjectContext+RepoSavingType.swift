//
//  NSManagedObjectContext+RepoSavingType.swift
//  DBRepo
//
//  Created by Daniel Bennett on 10/07/2016.
//  Copyright © 2016 Dan Bennett. All rights reserved.
//

import Foundation
import CoreData

extension NSManagedObjectContext : RepoSavingType {
    
    public func beginWrite() {
        // We don't need to do anything here.
    }
    
    public func endWrite() throws {
        try self.save()
        // Save up the chain to disk.
        if let parentContext = self.parentContext {
            try parentContext.endWrite()
        }
    }
    
}