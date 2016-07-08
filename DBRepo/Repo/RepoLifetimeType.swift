//
//  RepoLifetimeType.swift
//  DBRepo
//
//  Created by Daniel Bennett on 09/07/2016.
//  Copyright © 2016 Dan Bennett. All rights reserved.
//

import Foundation

public protocol RepoLifetimeType {
    func addEntity<T : EntityType>(type : T.Type) throws -> T
//    func removeEntity(entity : EntityType)
}
