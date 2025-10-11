//
//  ClearPairRecordRequest.swift
//  DeviceManager
//
//  Created by Bluetrum.
//  

import Foundation

public final class ClearPairRecordRequest: Request {
    
    public init() {
        super.init(Command.COMMAND_CLEAR_PAIR_RECORD)
    }
    
}
