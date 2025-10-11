//
//  UInt32PayloadHandler.swift
//  DeviceManager
//
//  Created by Bluetrum on 2022/3/7.
//

import Foundation

public final class UInt32PayloadHandler: AbstractPayloadHandler {
    
    public override func callAsFunction() -> Any? {
        if payload.count == 4 {
            var value: UInt32
            value = UInt32(payload[3]) << 24 | UInt32(payload[2]) << 16 | UInt32(payload[1]) << 8 | UInt32(payload[0])
            return value
        }
        return nil
    }
    
}
