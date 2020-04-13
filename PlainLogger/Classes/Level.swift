//
//  Level.swift
//  PlainLogger
//
//  Created by Burak Akkaş on 31.01.2019.
//  Copyright © 2019 Burak Akkaş. All rights reserved.
//

import Foundation

extension PlainLogger {
    // MARK: - LogLevel
    public enum Level: String {
        case info = "Info"
        case error = "Error"
        case debug = "Debug"
        case verbose = "Verbose"
    }
}
