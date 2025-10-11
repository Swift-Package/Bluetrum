//
//  EqRequest.swift
//  DeviceManager
//
//  Created by Bluetrum.
//  

import Foundation
import Utils

public final class EqRequest: Request {
    
    public private(set) var segmentNum: UInt8
    public private(set) var eqMode: UInt8
    public private(set) var gains: [Int8]
    
    public init(segmentNum: UInt8, eqMode: UInt8, gains: [Int8]) {
        self.segmentNum = segmentNum
        self.eqMode = eqMode
        self.gains = [Int8](repeating: 0, count: Int(RemoteEqSetting.DEFAULT_SEGMENT_NUMBER))
        super.init(Command.COMMAND_EQ)
        
        if segmentNum <= gains.count {
            for i in 0..<Int(segmentNum) {
                self.gains[i] = gains[i]
            }
        } else {
            for (i, gain) in gains.enumerated() {
                self.gains[i] = gain
            }
            for i in Int(gains.count)..<Int(segmentNum) {
                self.gains[i] = 0
            }
        }
    }
    
    public convenience init(eqMode: UInt8, gains: [Int8]) {
        self.init(segmentNum: RemoteEqSetting.DEFAULT_SEGMENT_NUMBER, eqMode: eqMode, gains: gains)
    }
    
    public override func getPayload() -> Data {
        let payloadLength = 2 + segmentNum
        let bb = ByteBuffer(size: Int(payloadLength))
        bb.put(segmentNum)
        bb.put(eqMode)
        bb.put(gains)
        return bb.data()
    }
    
    public static func PresetEqRequest(eqMode: UInt8, gains: [Int8]) -> EqRequest {
        return EqRequest(segmentNum: RemoteEqSetting.DEFAULT_SEGMENT_NUMBER, eqMode: eqMode, gains: gains)
    }
    
    public static func CustomEqRequest(eqMode: UInt8, gains: [Int8]) -> EqRequest {
        return EqRequest(segmentNum: RemoteEqSetting.DEFAULT_SEGMENT_NUMBER, eqMode: RemoteEqSetting.CUSTOM_START_INDEX + eqMode, gains: gains)
    }
    
}
