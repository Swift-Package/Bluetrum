//
//  BassEngineRequest.swift
//  DeviceManager
//
//  Created by Bluetrum on 2023/6/12.
//

import Foundation

public final class BassEngineRequest: TlvRequest {
    
    public static let BASS_ENGINE_STATUS: UInt8     = 1
    public static let BASS_ENGINE_VALUE: UInt8      = 2
    
    private(set) var enable: Bool?
    private(set) var value: UInt8?
    
    private init(enable: Bool? = nil, value: UInt8? = nil) {
        self.enable = enable
        self.value = value
        super.init(Command.COMMAND_BASS_ENGINE)
    }
    
    public static func enableRequest(enable: Bool) -> BassEngineRequest {
        return BassEngineRequest(enable: enable)
    }
    
    // 这里用的是Int8，再转成UInt8
    public static func valueRequest(value: Int8) -> BassEngineRequest {
        return BassEngineRequest(value: UInt8(bitPattern: value))
    }
    
    public override func getTlvObjectDict() -> [UInt8: Any?] {
        [
            BassEngineRequest.BASS_ENGINE_STATUS: enable,
            BassEngineRequest.BASS_ENGINE_VALUE: value,
        ]
    }
}
