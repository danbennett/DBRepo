//
//  NSManagedObject+EntityType.swift
//  DBRepo
//
//  Created by Daniel Bennett on 09/07/2016.
//  Copyright © 2016 Dan Bennett. All rights reserved.
//

import Foundation
import CoreData

extension NSManagedObject : EntityType {
    
    public static var className : String {
        let components = NSStringFromClass(self).componentsSeparatedByString(".")
        return components[1]
    }
    
}