//
//  CommandProtocol.swift
//  DeviceManager
//
//  Created by Bluetrum.
//  

import Foundation

public protocol CommandProtocol {
    
    func getCommand() -> UInt8
    
    func getCommandType() -> UInt8
    
    func getPayload() -> Data
    
}
