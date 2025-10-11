//
//  DeviceInfoRemoteEqSettingsCallable.swift
//  DeviceManager
//
//  Created by Bluetrum on 2022/3/4.
//

import Foundation
import Utils

@available(*, deprecated, message: "Use class inheriting from 'PayloadHandler'.")
public final class DeviceInfoRemoteEqSettingsCallable: AbstractDeviceInfoCallable {
    
    public override func callAsFunction() -> Any? {
        guard payload.count > 1 else {
            return nil
        }
        
        var remoteEqSettings: [RemoteEqSetting] = []
        
        let bb = ByteBuffer.wrap(payload)
        let bandNum = Int(bb.get() as UInt8)
        
        while bb.remainning >= 1 + bandNum {
            let eqMode = bb.get()
            var gainsData = Data(count: bandNum)
            bb.get(&gainsData)
            
            let gains = gainsData.map { Int8(bitPattern: $0) }
            remoteEqSettings.append(RemoteEqSetting(mode: eqMode, gains: gains))
        }
        
        return remoteEqSettings
    }
    
}
