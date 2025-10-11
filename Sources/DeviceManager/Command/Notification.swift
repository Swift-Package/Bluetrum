//
//  Notification.swift
//  DeviceManager
//
//  Created by Bluetrum.
//  

import Foundation

// MARK: - 设备Notify型命令回复
open class Notification: Command {
    
    private let command: UInt8
    private let commandType: UInt8
    private let commandData: Data
    
    public convenience init(_ command: UInt8) {
        self.init(command, commandData: Data())
    }
    
    public required init(_ command: UInt8, commandData: Data) {
        self.command = command
        self.commandType = Command.COMMAND_TYPE_NOTIFY
        self.commandData = commandData
    }
    
    public override func getCommand() -> UInt8 { command }
    
    public override func getCommandType() -> UInt8 { commandType }
    
    public override func getPayload() -> Data { commandData }
}
