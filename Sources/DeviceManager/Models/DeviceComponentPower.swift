//
//  DeviceComponentPower.swift
//  DeviceManager
//
//  Created by Bluetrum.
//  

import Foundation

public final class DeviceComponentPower {
    
    public let powerLevel: Int
    public let isCharging: Bool
    
    public init(powerLevel: Int, isCharging: Bool) {
        self.powerLevel = powerLevel
        self.isCharging = isCharging
    }
    
    public convenience init(powerData: UInt8) {
        let isCharging = (powerData & 0x80) != 0
        let powerLevel = Int(powerData & 0x7F)
        self.init(powerLevel: powerLevel, isCharging: isCharging)
    }
    
}

extension DeviceComponentPower: CustomStringConvertible {
    
    public var description: String {
        return "(\(powerLevel), \(isCharging))"
    }
    
}
