//
//  DeviceInfoDataCallable.swift
//  DeviceManager
//
//  Created by Bluetrum.
//  

import Foundation

@available(*, deprecated, message: "Use class inheriting from 'PayloadHandler'.")
public final class DeviceInfoDataCallable: AbstractDeviceInfoCallable {
    
    public override func callAsFunction() -> Any? {
        return payload
    }
    
}
