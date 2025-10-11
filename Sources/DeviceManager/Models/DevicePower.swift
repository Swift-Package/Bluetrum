//
//  DevicePower.swift
//  DeviceManager
//
//  Created by Bluetrum.
//  

import Foundation

public final class DevicePower {
    
    public private(set) var leftSidePower: DeviceComponentPower?
    public private(set) var rightSidePower: DeviceComponentPower?
    public private(set) var casePower: DeviceComponentPower?
    
    public init(powerData: Data) {
        if powerData.count > 0 {
            let data = powerData[0]
            leftSidePower = DeviceComponentPower(powerData: data)
        }
        if powerData.count > 1 {
            let data = powerData[1]
            rightSidePower = DeviceComponentPower(powerData: data)
        }
        if powerData.count > 2 {
            let data = powerData[2]
            casePower = DeviceComponentPower(powerData: data)
        }
    }
    
}

extension DevicePower: CustomStringConvertible {
    
    public var description: String {
        return "Left: \(String(describing: leftSidePower)), Right: \(String(describing: rightSidePower)), Case: \(String(describing: casePower))"
    }
    
}
