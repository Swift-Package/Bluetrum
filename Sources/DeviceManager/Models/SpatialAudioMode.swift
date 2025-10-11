//
//  SpatialAudioMode.swift
//  DeviceManager
//
//  Created by Bluetrum on 2023/4/27.
//

import Foundation

public enum SpatialAudioMode: UInt8 {
    case off            = 0
    case fixed          = 1
    case headTracking   = 2
    
    /// 不支持Head Tracking可以使用这个简化
    public init(on: Bool) {
        self.init(rawValue: on ? SpatialAudioMode.fixed.rawValue : SpatialAudioMode.off.rawValue)!
    }
    
    public var mode: UInt8 { rawValue }
    
    public var isOn: Bool {
        return rawValue != SpatialAudioMode.off.rawValue
    }
}
