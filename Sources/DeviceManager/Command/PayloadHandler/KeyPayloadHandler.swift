//
//  KeyPayloadHandler.swift
//  DeviceManager
//
//  Created by Bluetrum on 2022/3/7.
//

import Foundation

public final class KeyPayloadHandler: AbstractPayloadHandler {
    
    public override func callAsFunction() -> Any? {
        
        var resultDict: [KeyType: KeyFunction] = [:]
        
        var i = 0
        while payload.count - i >= 3 {
            let t = payload[i]
            let l = payload[i + 1]
            if l != 1 {
                i += (2 + Int(l))
                continue
            }
            let v = payload[i + 2]
            
            if let type = KeyType(rawValue: t),
               let function = KeyFunction(rawValue: v) {
                resultDict[type] = function
            }
            
            i += 3
        }
        
        return resultDict
    }
    
}
