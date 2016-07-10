//
//  RepoSavingType.swift
//  DBRepo
//
//  Created by Daniel Bennett on 10/07/2016.
//  Copyright © 2016 Dan Bennett. All rights reserved.
//

import Foundation

public protocol RepoSavingType {
    func beginWrite()
    func endWrite() throws
}