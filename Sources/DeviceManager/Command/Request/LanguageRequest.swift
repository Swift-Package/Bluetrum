//
//  LanguageRequest.swift
//  DeviceManager
//
//  Created by Bluetrum.
//  

import Foundation

public enum LanguageSetting: UInt8 {
    case english        = 0x00
    case chinese        = 0x01
}

public final class LanguageRequest: Request {
    
    public private(set) var setting: LanguageSetting
    
    public init(_ setting: LanguageSetting) {
        self.setting = setting
        super.init(Command.COMMAND_LANGUAGE)
    }
    
    public override func getPayload() -> Data {
        return Data([setting.rawValue])
    }
    
}
