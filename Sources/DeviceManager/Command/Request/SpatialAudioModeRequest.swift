//
//  SpatialAudioModeRequest.swift
//  DeviceManager
//
//  Created by Bluetrum on 2023/4/27.
//

import Foundation

public final class SpatialAudioModeRequest: Request {
    
    private let mode: SpatialAudioMode
    
    public init(mode: SpatialAudioMode) {
        self.mode = mode
        super.init(Command.COMMAND_SPATIAL_AUDIO_MODE)
    }
    
    /// 不支持Head Tracking可以使用这个简化
    public convenience init(on: Bool) {
        self.init(mode: SpatialAudioMode(on: on))
    }
    
    public override func getPayload() -> Data {
        return Data([mode.mode])
    }
}
