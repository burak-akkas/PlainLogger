//
//  LogDataStoreModel.swift
//  PlainLogger
//
//  Created by Burak Akkaş on 31.01.2019.
//  Copyright © 2019 Burak Akkaş. All rights reserved.
//

import Foundation

// MARK: - Log data store model
public final class LogDataStoreModel: NSObject, NSCoding {
    var level: String
    var tag: String
    var message: String
    var function: String
    var column: Int
    var line: Int
    var file: String
    var date: String
    
    required init(level: String, tag: String, message: String,
         function: String, column: Int, line: Int, file: String,
         date: String) {
        self.level = level
        self.tag = tag
        self.message = message
        self.function = function
        self.column = column
        self.line = line
        self.file = file
        self.date = date
        super.init()
    }
    
    public init?(coder aDecoder: NSCoder) {
        level = aDecoder.decodeObject(forKey: "level") as! String
        tag = aDecoder.decodeObject(forKey: "tag") as! String
        message = aDecoder.decodeObject(forKey: "message") as! String
        function = aDecoder.decodeObject(forKey: "function") as! String
        column = aDecoder.decodeInteger(forKey: "column")
        line = aDecoder.decodeInteger(forKey: "line")
        file = aDecoder.decodeObject(forKey: "file") as! String
        date = aDecoder.decodeObject(forKey: "date") as! String
    }
    
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(level, forKey: "level")
        aCoder.encode(tag, forKey: "tag")
        aCoder.encode(message, forKey: "message")
        aCoder.encode(function, forKey: "function")
        aCoder.encode(line, forKey: "line")
        aCoder.encode(column, forKey: "column")
        aCoder.encode(file, forKey: "file")
        aCoder.encode(date, forKey: "date")
    }
}
