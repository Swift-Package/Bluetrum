//
//  SoundEffect3dRequest.swift
//  DeviceManager
//
//  Created by Bluetrum on 2022/6/24.
//

import Foundation

@available(*, deprecated, message: "Use SpatialAudioModeRequest instead.")
public final class SoundEffect3dRequest: BoolRequest {
    
    public init(_ on: Bool) {
        super.init(Command.COMMAND_SOUND_EFFECT_3D, on)
    }
}
