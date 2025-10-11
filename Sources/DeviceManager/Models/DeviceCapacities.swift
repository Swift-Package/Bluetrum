//
//  DeviceCapacities.swift
//  DeviceManager
//
//  Created by Bluetrum on 2023/6/5.
//

import Foundation

public struct DeviceCapacities: OptionSet, Sendable {
    public let rawValue: UInt16
    
    public init(rawValue: UInt16) {
        self.rawValue = rawValue
    }
    
    public static let supportTws            = DeviceCapacities(rawValue: 1 << 0)
    public static let supportSoundEffect3d  = DeviceCapacities(rawValue: 1 << 1)
    public static let supportSpatialAudio   = DeviceCapacities(rawValue: 1 << 1) // supportSoundEffect3d
    public static let supportMultipoint     = DeviceCapacities(rawValue: 1 << 2)
    public static let supportAnc            = DeviceCapacities(rawValue: 1 << 3)
    public static let supportVoiceRecognition = DeviceCapacities(rawValue: 1 << 4)
    public static let supportBassEngine     = DeviceCapacities(rawValue: 1 << 5)
    public static let supportAntiWindNoise  = DeviceCapacities(rawValue: 1 << 6)
    
    public var supportTws: Bool             { contains(.supportTws) }
    public var supportSoundEffect3d: Bool   { contains(.supportSoundEffect3d) }
    public var supportSpatialAudio: Bool    { contains(.supportSpatialAudio) }
    public var supportMultipoint: Bool      { contains(.supportMultipoint) }
    public var supportAnc: Bool             { contains(.supportAnc) }
    public var supportVoiceRecognition: Bool { contains(.supportVoiceRecognition) }
    public var supportBassEngine: Bool      { contains(.supportBassEngine) }
    public var supportAntiWindNoise: Bool   { contains(.supportAntiWindNoise) }
}
