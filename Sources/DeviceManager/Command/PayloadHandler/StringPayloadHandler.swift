//
//  StringPayloadHandler.swift
//  DeviceManager
//
//  Created by Bluetrum on 2022/3/7.
//

import Foundation

public final class StringPayloadHandler: AbstractPayloadHandler {
    
    public override func callAsFunction() -> Any? {
        return String(bytes: payload, encoding: .utf8)
    }
    
}
