//
//  DatabaseConnection.swift
//  DBRepo
//
//  Created by Daniel Bennett on 08/07/2016.
//  Copyright © 2016 Dan Bennett. All rights reserved.
//

import Foundation

public protocol DatabaseConnection {
    init (storeName: String)
    func setup() throws
}