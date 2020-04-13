//
//  PlainLogger.swift
//  PlainLogger
//
//  Created by Burak Akkaş on 30.01.2019.
//  Copyright © 2019 Burak Akkaş. All rights reserved.
//

import Foundation

public final class PlainLogger {
    private static var configuration: Configuration = Configuration()
    
    private init() {}
    
    public static func configure(with configuration: Configuration) {
        PlainLogger.configuration = configuration
    }
    
    public static func debug(tag: String = "", message: String,
                      function: String = #function, column: Int = #column,
                      line: Int = #line, file: String = #file) {
        writeLog(on: .debug, tag: tag, message: message, function: function, column: column, line: line, file: file)
    }
    
    public static func verbose(tag: String = "", message: String,
                      function: String = #function, column: Int = #column,
                      line: Int = #line, file: String = #file) {
        writeLog(on: .verbose, tag: tag, message: message, function: function, column: column, line: line, file: file)
    }
    
    public static func error(tag: String = "", message: String,
                      function: String = #function, column: Int = #column,
                      line: Int = #line, file: String = #file) {
        writeLog(on: .error, tag: tag, message: message, function: function, column: column, line: line, file: file)
    }
    
    public static func info(tag: String = "", message: String,
                      function: String = #function, column: Int = #column,
                      line: Int = #line, file: String = #file) {
        writeLog(on: .info, tag: tag, message: message, function: function, column: column, line: line, file: file)
    }
    
    private static func writeLog(on loggingLevel: Level, tag: String, message: String,
                            function: String, column: Int,
                            line: Int, file: String) {
        if configuration.isEnabled {
            let globalConfigurationLevel = configuration.level
            if globalConfigurationLevel == loggingLevel || globalConfigurationLevel == .verbose {
                // Prepare log
                let _date = formatLogDate(Date())
                let _log = prepareConsoleLog(on: loggingLevel, tag: tag, message: message, function: function, column: column, line: line, file: file, date: _date)
                
                // Print log to console
                print(_log)
                
                // Store log on providers
                if let providers = configuration.dataProviders {
                    for provider in providers {
                        provider.store(log: LogDataStoreModel(level: loggingLevel.rawValue, tag: tag, message: message, function: function, column: column, line: line, file: file, date: _date))
                    }
                }
            }
        }
    }
    
    private static func prepareConsoleLog(on loggingLevel: Level, tag: String, message: String,
                                   function: String, column: Int,
                                   line: Int, file: String, date: String) -> String {
        return replaceTemplate(loggingLevel: loggingLevel, tag: tag, message: message, function: function, column: column, line: line, file: file, date: date)
    }
    
    private static func replaceTemplate(loggingLevel: Level, tag: String,
                                        message: String, function: String, column: Int,
                                        line: Int, file: String, date: String) -> String {
        
        var template = configuration.consoleLoggingTemplate ?? "#line_break# #logger_signature# #log_level# #date#" +
                                                                "#line_break# #indicator# Tag: #tag#" +
                                                                "#line_break# #indicator# Message: #message#" +
                                                                "#line_break# #indicator# Function: #function#" +
                                                                "#line_break# #indicator# File: #file#" +
                                                                "#line_break# #indicator# Line: #line#, Column: #column#"
        let url = URL(fileURLWithPath: file)
        let indicator = configuration.indicatorsEnabled ? configuration.indicatorScheme.getIndicator(for: loggingLevel).rawValue : ""
        let templateDictionary = ["line_break": "\n",
                                "logger_signature": "[📋 Log]",
                                "log_level": "[🔎 \(loggingLevel.rawValue)]",
                                "date": "[⏰ \(date)]",
                                "indicator": indicator,
                                "tag": tag,
                                "message": message,
                                "function": function,
                                "file": url.lastPathComponent,
                                "line": "\(line)",
                                "column": "\(column)"]
        
        for (key, value) in templateDictionary {
            template = template.replacingOccurrences(of: "#" + key + "#", with: value)
        }
        
        return template
    }
    
    private static func formatLogDate(_ date: Date) -> String {
        let format = configuration.dateFormat
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: date)
    }
}
