//
//  DeviceInfoUInt16Callable.swift
//  DeviceManager
//
//  Created by Bluetrum.
//  

import Foundation

@available(*, deprecated, message: "Use class inheriting from 'PayloadHandler'.")
public final class DeviceInfoUInt16Callable: AbstractDeviceInfoCallable {
    
    public override func callAsFunction() -> Any? {
        if payload.count == 2 {
            var value: UInt16
            value = UInt16(payload[1]) << 8 | UInt16(payload[0])
            return value
        }
        return nil
    }
    
}
