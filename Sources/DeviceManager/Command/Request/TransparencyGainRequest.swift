//
//  TransparencyGainRequest.swift
//  DeviceManager
//
//  Created by Bluetrum on 2022/3/3.
//

import Foundation

@available(*, deprecated, message: "Use AncRequest.")
public final class TransparencyGainRequest: Request {
    
    public private(set) var gain: UInt8
    
    public override init(_ gain: UInt8) {
        self.gain = gain
        super.init(Command.COMMAND_TRANSPARENCY_GAIN)
    }
    
    public override func getPayload() -> Data {
        return Data([gain])
    }
    
}
