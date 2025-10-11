//
//  BassEngineRange.swift
//  DeviceManager
//
//  Created by Bluetrum on 2023/6/12.
//

import Foundation

public final class BassEngineRange {
    
    public let minValue: Int8
    public let maxValue: Int8
    
    public init(minValue: Int8, maxValue: Int8) {
        self.minValue = minValue
        self.maxValue = maxValue
    }
}
