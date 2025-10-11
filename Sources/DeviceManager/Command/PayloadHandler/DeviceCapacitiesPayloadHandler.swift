//
//  DeviceCapacitiesPayloadHandler.swift
//  DeviceManager
//
//  Created by Bluetrum on 2022/6/24.
//

import Foundation

public final class DeviceCapacitiesPayloadHandler: AbstractPayloadHandler {
    
    public override func callAsFunction() -> Any? {
        if payload.count == 2 {
            let value = UInt16(payload[1]) << 8 | UInt16(payload[0])
            let deviceCapacities = DeviceCapacities(rawValue: value)
            return deviceCapacities
        }
        return nil
    }
    
}
