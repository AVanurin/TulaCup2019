//
//  MasterDBExtension.swift
//  TulaCup2019
//
//  Created by Ванурин Алексей on 11/04/2019.
//  Copyright © 2019 Ванурин Алексей. All rights reserved.
//

import Foundation
import SQLite3


extension MasterViewController {
    func test() {
        let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            .appendingPathComponent("test.sqlite")
        
        var db: OpaquePointer?
        if sqlite3_open(fileURL.path, &db) != SQLITE_OK {
            print("error opening database")
        }
    }
}
