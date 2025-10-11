//
//  MusicControlRequest.swift
//  DeviceManager
//
//  Created by Bluetrum.
//  

import Foundation

public enum MusicControlType {
    case volume(_ value: UInt8)
    case play
    case pause
    case previous
    case next
    
    public var rawValue: UInt8 {
        switch self {
        case .volume(_):    return 0x01
        case .play:         return 0x02
        case .pause:        return 0x03
        case .previous:     return 0x04
        case .next:         return 0x05
        }
    }
    
    fileprivate func getControlData() -> Data {
        switch self {
        case .volume(let value): return Data([rawValue, value])
        case .play:              fallthrough
        case .pause:             fallthrough
        case .previous:          fallthrough
        case .next:              return Data([rawValue])
        }
    }
}

public final class MusicControlRequest: TlvRequest {
    
    public private(set) var controlType: MusicControlType
    
    public init(_ controlType: MusicControlType) {
        self.controlType = controlType
        super.init(Command.COMMAND_MUSIC_CONTROL)
    }
    
    public override func getTlvObjectDict() -> [UInt8 : Any?] {
        [
            controlType.rawValue: controlType.getControlData(),
        ]
    }
}
