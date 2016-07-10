//
//  ViewController.swift
//  DBRepoExample
//
//  Created by Daniel Bennett on 10/07/2016.
//  Copyright © 2016 Dan Bennett. All rights reserved.
//

import UIKit
import DBRepo

class ViewController: UIViewController {

    var repo: protocol<RepoLifetimeType, RepoQueryType, RepoSavingType>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Note: Use error handling!
        
        // 1. Fetch existing object...
        let results = try! repo.fetch(Entity.self, predicate: nil)
        
        // If non exist ...
        if results.count == 0 {
            
            // 2. Begin write.
            repo.beginWrite()
            
            // 3. Create entity.
            let entity = try! self.repo.addEntity(Entity)
            entity.entityId = "unique id here"
            
            // 4. End write.
            try! repo.endWrite()
        }
        
    }


}

