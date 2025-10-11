//
//  BytePayloadHandler.swift
//  DeviceManager
//
//  Created by Bluetrum on 2022/3/7.
//

import Foundation

public final class UInt8PayloadHandler: AbstractPayloadHandler {
    
    public override func callAsFunction() -> Any? {
        if payload.count == 1 {
            return payload[0]
        }
        return nil
    }
    
}
