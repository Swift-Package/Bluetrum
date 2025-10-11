//
//  Int8PayloadHandler.swift
//  DeviceManager
//
//  Created by Bluetrum on 2023/6/14.
//

import Foundation

public final class Int8PayloadHandler: AbstractPayloadHandler {
    
    public override func callAsFunction() -> Any? {
        if payload.count == 1 {
            return Int8(bitPattern: payload[0])
        }
        return nil
    }
    
}
