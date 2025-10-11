//
//  DeviceInfoStringCallable.swift
//  DeviceManager
//
//  Created by Bluetrum.
//  

import Foundation

@available(*, deprecated, message: "Use class inheriting from 'PayloadHandler'.")
public final class DeviceInfoStringCallable: AbstractDeviceInfoCallable {
    
    public override func callAsFunction() -> Any? {
        return String(bytes: payload, encoding: .utf8)
    }
    
}
