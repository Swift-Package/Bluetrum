//
//  TlvBoolPayloadHandler.swift
//  DeviceManager
//
//  Created by Bluetrum on 2022/3/7.
//

import Foundation

public typealias TlvResponse = [UInt8: Bool]

public final class TlvResponsePayloadHandler: TlvPayloadHandler {
    
    public override func callAsFunction() -> Any? {
        
        guard let tlvData = super.callAsFunction() as? [UInt8: Data] else { return nil }
        
        var tlvResponse: TlvResponse = [:]
        
        for (key, value) in tlvData {
            if value.count == 1 {
                tlvResponse.updateValue(value[0] == 0x00, forKey: key)// TVL响应的是命令是否成功
            }
        }
        
        return tlvResponse
    }
}
