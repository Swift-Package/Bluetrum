//
//  TlvPayloadHandler.swift
//  DeviceManager
//
//  Created by Bluetrum on 2023/6/12.
//

import Foundation

// MARK: - 如果payload是TLV格式则解析成字典返回
open class TlvPayloadHandler: AbstractPayloadHandler {
    
    public override func callAsFunction() -> Any? {
        
        var tlvData: [UInt8: Data] = [:]
        
        var remaining = payload.count
        var i = 0
        while remaining >= 3 {
            let t = payload[i]
            let l = Int(payload[i + 1])
            i &+= 2
            remaining &-= 2
            if remaining < 0 || l > remaining {
                // 格式错误
                return nil
            }
            let v = payload.subdata(in: i..<i+l)
            tlvData[t] = v
            
            i &+= l
            remaining &-= l
        }
        if tlvData.count > 0 {
            return tlvData
        }
        return nil
    }
}
