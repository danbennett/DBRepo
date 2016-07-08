//
//  NSManagedObject+EntityType.swift
//  DBRepo
//
//  Created by Daniel Bennett on 09/07/2016.
//  Copyright © 2016 Dan Bennett. All rights reserved.
//

import Foundation
import CoreData

public extension EntityType where Self : NSManagedObject {
    
    public func deleteEntity() {
        self.managedObjectContext?.deleteObject(self)
    }
    
}