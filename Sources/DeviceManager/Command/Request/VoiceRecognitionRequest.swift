//
//  VoiceRecognitionRequest.swift
//  DeviceManager
//
//  Created by Bluetrum on 2023/6/12.
//

import Foundation

public final class VoiceRecognitionRequest: BoolRequest {
    
    public init(_ enable: Bool) {
        super.init(Command.COMMAND_VOICE_RECOGNITION, enable)
    }
}
