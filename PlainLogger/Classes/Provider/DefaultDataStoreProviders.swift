//
//  DefaultDataStoreProviders.swift
//  PlainLogger
//
//  Created by Burak Akkaş on 31.01.2019.
//  Copyright © 2019 Burak Akkaş. All rights reserved.
//

import Foundation

// MARK: - Default HTTP data store provider
public class DefaultHttpDataStoreProvider: LogDataStoreProvider {
    private var apiUrl: String
    
    required public init(apiUrl: String) {
        self.apiUrl = apiUrl
    }
    
    public func store(log: LogDataStoreModel) {
        if let request = prepareRequest(log: log) {
            doRequest(request: request, success: nil, failure: nil)
        }
    }
    
    public func identification() -> String {
        return "DefaultHttpDataStoreProvider"
    }
    
    private func prepareRequest(log: LogDataStoreModel) -> URLRequest? {
        if let url = URL(string: apiUrl) {
            return URLRequest(url: url)
        }
        return nil
    }
    
    private func doRequest(request: URLRequest, success: ((String) -> ())?, failure: ((String) -> ())?) {
        let task = URLSession.shared.dataTask(with: request as URLRequest, completionHandler: {(data, response, error) -> Void in
            if let httpResponse = response as? HTTPURLResponse {
                if error != nil {
                    // Error received
                    failure?(error?.localizedDescription ?? "Error received")
                } else {
                    let statusCode = httpResponse.statusCode
                    if statusCode == 200 {
                        guard let responseJson = String(data:data!, encoding:String.Encoding(rawValue: String.Encoding.utf8.rawValue))
                            else {
                                // No response
                                failure?("No response from network")
                                return
                        }
                        success?(responseJson)
                    }
                }
            }
        })
        task.resume()
    }
}

// MARK: - Default disk (user defaults) data store provider
public class DefaultDiskDataStoreProvider: LogDataStoreProvider {
    let userDefaults = UserDefaults.standard
    let diskDataStoreKey = "LoggerDiskDataStoreKey"
    
    public init() {}
    
    public func store(log: LogDataStoreModel) {
        if let logData = userDefaults.object(forKey: diskDataStoreKey) as? Data {
            if var logs = ((try? NSKeyedUnarchiver.unarchivedObject(ofClasses: [LogDataStoreModel.self], from: logData) as? [LogDataStoreModel]) as [LogDataStoreModel]??) {
                logs?.append(log)
                if let newData = try? NSKeyedArchiver.archivedData(withRootObject: logs as Any, requiringSecureCoding: false) {
                    userDefaults.set(newData, forKey: diskDataStoreKey)
                }
            }
        } else {
            if let newData = try? NSKeyedArchiver.archivedData(withRootObject: [log] as Any, requiringSecureCoding: false) {
                userDefaults.set(newData, forKey: diskDataStoreKey)
            }
        }
    }
    
    public func identification() -> String {
        return "DefaultDiskDataStoreProvider"
    }
}
