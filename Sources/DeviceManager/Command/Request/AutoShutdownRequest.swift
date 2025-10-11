//
//  AutoShutdownRequest.swift
//  DeviceManager
//
//  Created by Bluetrum.
//  

import Foundation

/**
 * 参数：0是立即关机，0xFF取消自动关机，中间其他数值[1, 0xFE]则是自定义关机时间
 */
public enum AutoShutdownSetting {
    case immediately
    case time(_ time: UInt8)
    case cancel
    
    fileprivate func getSettingData() -> Data {
        switch self {
        case .immediately:      return Data([0x00])
        case .time(let time):   return Data([time])
        case .cancel:           return Data([0xFF])
        }
    }
}

public final class AutoShutdownRequest: Request {
    
    public private(set) var setting: AutoShutdownSetting
    
    public init(_ setting: AutoShutdownSetting) {
        self.setting = setting
        super.init(Command.COMMAND_AUTO_SHUTDOWN)
    }
    
    public override func getPayload() -> Data {
        setting.getSettingData()
    }
    
}
