//
//  SpatialAudioModePayloadHandler.swift
//  DeviceManager
//
//  Created by Bluetrum on 2023/4/27.
//

import Foundation

public final class SpatialAudioModePayloadHandler: AbstractPayloadHandler {
    
    public override func callAsFunction() -> Any? {
        if payload.count == 1 {
            return SpatialAudioMode(rawValue: payload[0])
        }
        return nil
    }
}
