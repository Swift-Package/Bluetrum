//
//  RemoteEqSetting.swift
//  DeviceManager
//
//  Created by Bluetrum on 2022/3/4.
//

import Foundation

public struct RemoteEqSetting {
    
    public static let DEFAULT_SEGMENT_NUMBER: UInt8 = 10
    
    public static let CUSTOM_START_INDEX: UInt8 = 0x20		// 蓝讯设备自定义均衡器起始索引从 32 开始 如果使用 EqRequest.CustomEqRequest(eqMode: 1, gains: eqRestting) 意味着返回的 EqMode 的 Index 是 33
    
    public static let EQUALIZER_VIEW_MAX_VALUE: Int = 12 // 均衡器±最大增益
    
    public let mode: UInt8
    public let gains: [Int8]
    
    public init(mode: UInt8, gains: [Int8]) {
        self.mode = mode
        self.gains = gains
    }
    
}

public extension RemoteEqSetting {
    
    var isPreset: Bool {
        mode < RemoteEqSetting.CUSTOM_START_INDEX
    }
    
    var isCustom: Bool {
        mode >= RemoteEqSetting.CUSTOM_START_INDEX
    }
    
}

public extension RemoteEqSetting {
    
    /// Need isCustom to be true
    var customIndex: UInt8 {
        return mode - RemoteEqSetting.CUSTOM_START_INDEX
    }
    
}

extension RemoteEqSetting: Equatable {}

extension RemoteEqSetting: CustomStringConvertible {
    
    public var description: String {
        return "EqMode(\(mode)), \(gains)"
    }
    
}

public extension Array where Element == RemoteEqSetting {
    
    var preset: [RemoteEqSetting] {
        return filter { $0.mode < RemoteEqSetting.CUSTOM_START_INDEX }
    }
    
    var custom: [RemoteEqSetting] {
        return filter { $0.mode >= RemoteEqSetting.CUSTOM_START_INDEX }
    }
    
}
