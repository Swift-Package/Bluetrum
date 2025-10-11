//
//  AntiWindNoiseRequest.swift
//  DeviceManager
//
//  Created by Bluetrum on 2023/4/27.
//

import Foundation

public final class AntiWindNoiseRequest: BoolRequest {

    public init(_ on: Bool) {
        super.init(Command.COMMAND_ANTI_WIND_NOISE, on)
    }
}
