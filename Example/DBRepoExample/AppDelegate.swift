//
//  AppDelegate.swift
//  DBRepoExample
//
//  Created by Daniel Bennett on 10/07/2016.
//  Copyright © 2016 Dan Bennett. All rights reserved.
//

import UIKit
import DBRepo

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {

        // Core data setup
        let coreDataConnection = CoreDataConnection(storeName: "ExampleDataBase.sqlite")
        try! coreDataConnection.setup()
        
        // Create view controller...
        if let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController() as? ViewController {
            
            let navController = UINavigationController(rootViewController: viewController)
            // Set repo property...
            viewController.repo = coreDataConnection.mainContext
            
            self.window?.rootViewController = navController
            self.window?.makeKeyAndVisible()
            
        }
        
        return true
    }

}

