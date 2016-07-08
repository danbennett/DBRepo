//
//  NSManagedObjectContext+name.swift
//  DBRepo
//
//  Created by Daniel Bennett on 09/07/2016.
//  Copyright © 2016 Dan Bennett. All rights reserved.
//

import Foundation
import CoreData

extension NSManagedObjectContext {
    var contextName : String {
        get {
            return self.userInfo["context_name"] as! String
        }
        set {
            self.userInfo["context_name"] = newValue
        }
    }
}