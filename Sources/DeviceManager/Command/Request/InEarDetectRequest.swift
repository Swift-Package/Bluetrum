//
//  InEarDetectRequest.swift
//  DeviceManager
//
//  Created by Bluetrum.
//  

import Foundation

public final class InEarDetectRequest: BoolRequest {
    
    public init(_ enable: Bool) {
        super.init(Command.COMMAND_IN_EAR_DETECT, enable)
    }
}
