//
//  DeviceInfoUInt32Callable.swift
//  DeviceManager
//
//  Created by Bluetrum.
//  

import Foundation

@available(*, deprecated, message: "Use class inheriting from 'PayloadHandler'.")
public final class DeviceInfoUInt32Callable: AbstractDeviceInfoCallable {
    
    public override func callAsFunction() -> Any? {
        if payload.count == 4 {
            var value: UInt32
            value = UInt32(payload[3]) << 24 | UInt32(payload[2]) << 16 | UInt32(payload[1]) << 8 | UInt32(payload[0])
            return value
        }
        return nil
    }
    
}
