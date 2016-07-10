//
//  NSManagedObjectContext+RepoQueryType.swift
//  DBRepo
//
//  Created by Daniel Bennett on 09/07/2016.
//  Copyright © 2016 Dan Bennett. All rights reserved.
//

import Foundation
import CoreData

extension NSManagedObjectContext : RepoQueryType {
    
    public func fetch<T : EntityType>(type : T.Type, predicate : NSPredicate?) throws -> [T] {
        let className = type.className
        guard let request = self.fetchRequest(className) else {
            throw NSError (domain: "com.havaslynx.hlrepo", code: 8001, userInfo: [NSLocalizedDescriptionKey : "No entity matches that name"])
        }
        
        var results: [T]!
        var responseError: ErrorType?
        
        self.performBlockAndWait { () -> Void in
            do {
                results = try self.executeFetchRequest(request) as? [T]
            } catch {
                responseError = error
            }
        }
        if responseError != nil {  throw responseError!  }
        return results ?? []
    }
    
}

private extension NSManagedObjectContext {
    
    func fetchRequest (className: String) -> NSFetchRequest? {
        guard let description = NSEntityDescription.entityForName(className, inManagedObjectContext: self) else {  return nil  }
        let request = NSFetchRequest(entityName: className)
        request.entity = description
        return request
    }
    
}