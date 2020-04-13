//
//  LogDataStoreProvider.swift
//  PlainLogger
//
//  Created by Burak Akkaş on 31.01.2019.
//  Copyright © 2019 Burak Akkaş. All rights reserved.
//

import Foundation

// MARK: - Log data store provider
public protocol LogDataStoreProvider {
    func store(log: LogDataStoreModel)
    
    // Data store providers identificaton
    func identification() -> String
}
