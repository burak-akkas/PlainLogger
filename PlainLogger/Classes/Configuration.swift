//
//  Configuration.swift
//  PlainLogger
//
//  Created by Burak Akkaş on 31.01.2019.
//  Copyright © 2019 Burak Akkaş. All rights reserved.
//

import Foundation

extension PlainLogger {
    // MARK: - LogConfiguration
    public final class Configuration {
        var isEnabled: Bool
        var dateFormat: String
        var level: Level
        var indicatorsEnabled: Bool
        var indicatorScheme: IndicatorScheme
        var dataProviders: [LogDataStoreProvider]?
        var consoleLoggingTemplate: String?
        
        required public init(enabled: Bool = true, level: Level = .verbose,
                      dateFormat: String = "dd/MM/yyyy HH:mm", indicatorsEnabled: Bool = true,
                      indicatorScheme: IndicatorScheme = IndicatorScheme(),
                      consoleLoggingTemplate: String? = nil, providers: [LogDataStoreProvider]? = nil) {
            self.isEnabled = enabled
            self.level = level
            self.dateFormat = dateFormat
            self.indicatorsEnabled = indicatorsEnabled
            self.indicatorScheme = indicatorScheme
            self.dataProviders = providers
            self.consoleLoggingTemplate = consoleLoggingTemplate
        }
    }
}
