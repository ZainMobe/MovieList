//
//  LogsManager.swift
//  Movie List
//
//  Created by Zain Haider on 05/01/2022.
//

import Foundation

/// Log everything from here.
class LogsManager: NSObject {
    /// Private constructor
    private override init() {
    }
    /// Shared manager
    static let shared = LogsManager()
    /// Switch to turn off/on console logs
    var showLogs = true
    /// Log any string
    /// - Parameter message: Message in String formate.
    func logMessage(message: String?) {
        guard showLogs else {return}
        print(message ?? "Log not found")
    }
    /// Log type
    enum logType {
        case beforeHittingAPI
        case afterHittingAPI
        case error
    }
    /// Log api responses
    /// - Parameters:
    ///   - type: Log type is enum.
    ///   - url: URL of api.
    ///   - response: Response of api
    ///   - error: Error in response
    ///   - params: params to send while making call
    func logAPI(type: logType, url: String, response: Any? = nil, error: Any? = nil, params: [String: Any] = [:]) {
        guard showLogs else {return}
        print("\n\n--------------Printing Api Logs--------------")
        print("-------------------------------------------------\n\n")
        switch type {
        case .beforeHittingAPI:
            print("Before Hitting API")
            print("API URL: ", url)
            print("API Params: ", params)
        case .afterHittingAPI:
            print("After Hitting API")
            print("API URL: ", url)
            if let res = response {
                print("API Response: ", res)
            }
        case .error:
            print("Printing Error Description For: \n")
            print("API URL: ", url)
            if let err = error {
                print("Error: ", err)
            }
        }
        print("\nTimeStamp: ", "\(Date())")
        print("\n\n-----------------------End Api Logs----------------------")
        print("--------------------------------------------------------\n\n")
    }

}
