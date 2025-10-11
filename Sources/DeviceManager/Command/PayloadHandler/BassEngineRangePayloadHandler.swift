//
//  BassEngineValuePayloadHandler.swift
//  DeviceManager
//
//  Created by Bluetrum on 2023/4/27.
//

import Foundation

public final class BassEngineRangePayloadHandler: AbstractPayloadHandler {
    
    public override func callAsFunction() -> Any? {
        if payload.count == 2 {
            let minValue = Int8(bitPattern: payload[0])
            let maxValue = Int8(bitPattern: payload[1])
            return BassEngineRange(minValue: minValue, maxValue: maxValue)
        }
        return nil
    }
}
