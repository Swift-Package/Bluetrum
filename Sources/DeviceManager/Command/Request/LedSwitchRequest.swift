//
//  LedSwitchRequest.swift
//  DeviceManager
//
//  Created by Bluetrum.
//  

import Foundation

public final class LedSwitchRequest: BoolRequest {
    
    public init(_ ledOn: Bool) {
        super.init(Command.COMMAND_LED_MODE, ledOn)
    }
}
