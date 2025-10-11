//
//  Request.swift
//  DeviceManager
//
//  Created by Bluetrum.
//  

import Foundation

open class Request: Command {
    
    private static let DEFAULT_REQUEST_TIMEOUT = 5
    
    private let command: UInt8
    private let commandType: UInt8
    
    /// 默认带回复写，OTA使用不带回复
    /// Default is writing with response
    /// Without response for FOTA
    open var leWriteWithResponse: Bool { true }
    
    /// 请求超时时间
    /// Request timeout
    open var timetout = DEFAULT_REQUEST_TIMEOUT
    
    private let random = arc4random() // Hashable. Use random to make each request unique
    
    public init(_ command: UInt8) {
        self.command = command
        self.commandType = Command.COMMAND_TYPE_REQUEST
    }
    
    public override func getCommand() -> UInt8 { command }
    
    public override func getCommandType() -> UInt8 { commandType }
    
}

extension Request: Hashable {
    public static func == (lhs: Request, rhs: Request) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(command)
        hasher.combine(commandType)
        hasher.combine(random)
    }
}
