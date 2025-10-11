//
//  WorkModeRequest.swift
//  DeviceManager
//
//  Created by Bluetrum.
//  

import Foundation

public enum WorkMode: UInt8 {
    case normal     = 0x00
    case gaming     = 0x01
}

public final class WorkModeRequest: Request {
    
    public private(set) var workMode: WorkMode
    
    public init(_ workMode: WorkMode) {
        self.workMode = workMode
        super.init(Command.COMMAND_WORK_MODE)
    }
    
    public override func getPayload() -> Data {
        return Data([workMode.rawValue])
    }
    
}
