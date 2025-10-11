//
//  LoggerDelegate.swift
//  ABMATEDemo
//
//  Created by Bluetrum on 2021/10/28.
//

import Foundation

public enum LogLevel: Int {
    case debug       = 0
    case verbose     = 1
    case info        = 5
    case application = 10
    case warning     = 15
    case error       = 20
    
    public var name: String {
        switch self {
        case .debug:       return "D"
        case .verbose:     return "V"
        case .info:        return "I"
        case .application: return "A"
        case .warning:     return "W"
        case .error:       return "E"
        }
    }
}

public protocol LoggerDelegate: AnyObject {
    func log(message: String, ofCategory category: String, withLevel level: LogLevel)
}

public extension LoggerDelegate {
    
    func d(_ category: String, _ message: String) {
        log(message: message, ofCategory: category, withLevel: .debug)
    }
    
    func v(_ category: String, _ message: String) {
        log(message: message, ofCategory: category, withLevel: .verbose)
    }
    
    func i(_ category: String, _ message: String) {
        log(message: message, ofCategory: category, withLevel: .info)
    }
    
    func a(_ category: String, _ message: String) {
        log(message: message, ofCategory: category, withLevel: .application)
    }
    
    func w(_ category: String, _ message: String) {
        log(message: message, ofCategory: category, withLevel: .warning)
    }
    
    func w(_ category: String, _ error: Error) {
        log(message: error.localizedDescription, ofCategory: category, withLevel: .warning)
    }
    
    func e(_ category: String, _ message: String) {
        log(message: message, ofCategory: category, withLevel: .error)
    }
    
    func e(_ category: String, _ error: Error) {
        log(message: error.localizedDescription, ofCategory: category, withLevel: .error)
    }
    
}
