//
//  DeviceInfoByteCallable.swift
//  DeviceManager
//
//  Created by Bluetrum.
//  

import Foundation

@available(*, deprecated, message: "Use class inheriting from 'PayloadHandler'.")
public final class DeviceInfoByteCallable: AbstractDeviceInfoCallable {
    
    public override func callAsFunction() -> Any? {
        if payload.count == 1 {
            return payload[0]
        }
        return nil
    }
    
}
