//
//  RepoQueryType.swift
//  DBRepo
//
//  Created by Daniel Bennett on 09/07/2016.
//  Copyright © 2016 Dan Bennett. All rights reserved.
//

import Foundation

public protocol RepoQueryType {
    func fetch<T : EntityType>(type : T.Type, predicate : NSPredicate?) throws -> [T] // TODO: Wrap result in sortable abstraction.
}