//
//  RemoteEqSettingPayloadHandler.swift
//  DeviceManager
//
//  Created by Bluetrum on 2022/3/7.
//

import Foundation
import Utils

public final class RemoteEqSettingPayloadHandler: AbstractPayloadHandler {
    
    public override func callAsFunction() -> Any? {
        guard payload.count > 2 else {
            return nil
        }
        
        let bb = ByteBuffer.wrap(payload)
        
        let bandNum = Int(bb.get() as UInt8)
        
        let eqMode = bb.get()
        var gainsData = Data(count: bandNum)
        bb.get(&gainsData)
        
        let gains = gainsData.map { Int8(bitPattern: $0) }
        return RemoteEqSetting(mode: eqMode, gains: gains)
    }
    
}
