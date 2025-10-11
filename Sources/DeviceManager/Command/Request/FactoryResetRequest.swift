//
//  FactoryResetRequest.swift
//  DeviceManager
//
//  Created by Bluetrum.
//  

import Foundation

public final class FactoryResetRequest: Request {
    
    public init() {
        super.init(Command.COMMAND_FACTORY_RESET)
    }
    
}
