//
//  DeviceInfoRemoteEqSettingCallable.swift
//  DeviceManager
//
//  Created by Bluetrum on 2022/3/4.
//

import Foundation
import Utils

@available(*, deprecated, message: "Use class inheriting from 'PayloadHandler'.")
public final class DeviceInfoRemoteEqSettingCallable: AbstractDeviceInfoCallable {
    
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
