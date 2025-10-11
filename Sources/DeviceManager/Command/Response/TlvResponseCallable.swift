//
//  TlvResponseCallable.swift
//  DeviceManager
//
//  Created by Bluetrum.
//  

import Foundation

//public typealias TlvResponse = [UInt8: Bool]

@available(*, deprecated, message: "Use class inheriting from 'PayloadHandler'.")
public final class TlvResponseCallable: AbstractResponseCallable {
    
    public override func callAsFunction() -> Any? {

        var tlvResponse: TlvResponse = [:]
        
        var i = 0
        while payload.count - i >= 3 {
            let t = payload[i]
            let l = payload[i + 1]
            if l != 1 {
                return nil // 格式不对
            }
            let v = payload[i + 2]
            tlvResponse[t] = (v == 0x00)
            i += 3
        }
        if tlvResponse.count > 0 {
            return tlvResponse
        }
        return nil
    }
    
}
