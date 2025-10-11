//
//  AutoAnswerRequest.swift
//  DeviceManager
//
//  Created by Bluetrum.
//  

import Foundation

public final class AutoAnswerRequest: BoolRequest {
    
    public init(_ enable: Bool) {
        super.init(Command.COMMAND_AUTO_ANSWER, enable)
    }
}
