//
//  FindDeviceRequest.swift
//  DeviceManager
//
//  Created by Bluetrum.
//  

import Foundation

public final class FindDeviceRequest: BoolRequest {
    
    public init(_ enable: Bool) {
        super.init(Command.COMMAND_FIND_DEVICE, enable)
    }
}
