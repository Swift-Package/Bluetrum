//
//  AncRequest.swift
//  DeviceManager
//
//  Created by Bluetrum on 2023/6/12.
//

import Foundation

public final class AncRequest: TlvRequest {
    
    public enum AncMode: UInt8 {
        case off            = 0x00
        case on             = 0x01
        case transparency   = 0x02
    }

    public static let MODE: UInt8               = 0x01
    public static let NC_LEVEL: UInt8           = 0x02
    public static let TRANSPARENCY_LEVEL: UInt8 = 0x03
    public static let FADE: UInt8               = 0x04
    
    private(set) var ancMode: AncMode?
    private(set) var ncLevel: UInt8?
    private(set) var transparencyLevel: UInt8?
    private(set) var enableFade: Bool?
    
    private init(ancMode: AncMode? = nil,
                 ncLevel: UInt8? = nil,
                 transparencyLevel: UInt8? = nil,
                 enableFade: Bool? = nil) {
        self.ancMode = ancMode
        self.ncLevel = ncLevel
        self.transparencyLevel = transparencyLevel
        self.enableFade = enableFade
        super.init(Command.COMMAND_ANC)
    }
    
    public static func modeRequest(ancMode: AncMode) -> AncRequest {
        return AncRequest(ancMode: ancMode)
    }
    
    public static func ncLevelRequest(ncLevel: UInt8) -> AncRequest {
        return AncRequest(ncLevel: ncLevel)
    }
    
    public static func transparencyLevelRequest(transparencyLevel: UInt8) -> AncRequest {
        return AncRequest(transparencyLevel: transparencyLevel)
    }
    
    public static func fadeRequest(enableFade: Bool) -> AncRequest {
        return AncRequest(enableFade: enableFade)
    }
    
    public override func getTlvObjectDict() -> [UInt8: Any?] {
        [
            AncRequest.MODE: ancMode?.rawValue,
            AncRequest.NC_LEVEL: ncLevel,
            AncRequest.TRANSPARENCY_LEVEL: transparencyLevel,
            AncRequest.FADE: enableFade,
        ]
    }
}
