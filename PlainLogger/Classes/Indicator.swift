//
//  Indicator.swift
//  PlainLogger
//
//  Created by Burak Akkaş on 31.01.2019.
//  Copyright © 2019 Burak Akkaş. All rights reserved.
//

import Foundation

extension PlainLogger {
    // MARK: - LogColor
    public enum Indicator: String {
        case normal = "🙂"
        case black = "🌑"
        case red = "🔴"
        case green = "❇️"
        case yellow = "🔶"
        case blue = "🔵"
        case white = "💀"
    }
    
    // MARK: - LogColorScheme
    public final class IndicatorScheme {
        private var debug: Indicator = Indicator.yellow
        private var info: Indicator = Indicator.blue
        private var verbose: Indicator = Indicator.normal
        private var error: Indicator = Indicator.red
        
        // Default
        public init() {}
        
        // Custom
        public init(debug: Indicator, info: Indicator, verbose: Indicator, error: Indicator) {
            self.debug = debug
            self.info = info
            self.verbose = verbose
            self.error = error
        }
        
        func getIndicator(for level: Level) -> Indicator {
            switch level {
            case .debug:
                return debug
            case .error:
                return error
            case .info:
                return info
            case .verbose:
                return verbose
            }
        }
    }
}
