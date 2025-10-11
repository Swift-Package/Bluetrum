//
//  PowerPayloadHandler.swift
//  DeviceManager
//
//  Created by Bluetrum on 2022/3/7.
//

import Foundation

public final class PowerPayloadHandler : AbstractPayloadHandler {
    
    public override func callAsFunction() -> Any? {
        if payload.count != 0 {
            return DevicePower(powerData: payload)
        }
        return nil
    }
    
}
