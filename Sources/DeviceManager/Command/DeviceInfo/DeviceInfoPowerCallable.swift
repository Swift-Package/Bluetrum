//
//  DeviceInfoPowerCallable.swift
//  DeviceManager
//
//  Created by Bluetrum.
//  

import Foundation

@available(*, deprecated, message: "Use class inheriting from 'PayloadHandler'.")
public final class DeviceInfoPowerCallable: AbstractDeviceInfoCallable {
    
    public override func callAsFunction() -> Any? {
        if payload.count != 0 {
            return DevicePower(powerData: payload)
        }
        return nil
    }
    
}
