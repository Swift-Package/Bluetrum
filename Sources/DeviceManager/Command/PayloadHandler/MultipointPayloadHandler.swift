//
//  MultipointPayloadHandler.swift
//  DeviceManager
//
//  Created by Bluetrum on 2023/6/12.
//

import Foundation

public final class MultipointPayloadHandler: AbstractPayloadHandler {
    
    private func deobfuscateAddress(_ address: Data) -> Data {
        var result = Data(count: 6)
        for (i, a) in address.enumerated() {
            result[i] = a ^ 0xAD
        }
        return result
    }
    
    public override func callAsFunction() -> Any? {
        var endpoints = [SinglePoint]()
        
        var remaining = payload.count
        var i = 0
        
        if remaining > 0 {
//            let count = payload[0]
            
            remaining -= 1
            i += 1
            
            // 这里考虑了蓝牙名称为空的情况
            while remaining >= 8 {
                let length = Int(payload[i])
                i += 1
                
                let addressBytes = Data(payload[i..<i+6])
                let address = deobfuscateAddress(addressBytes)
                i += 6
                
                let state = payload[i]
                i += 1
                
                let nameLength = length - 7 // -address, -state
                let nameBytes = Data(payload[i..<i+nameLength])
                let name = String(bytes: nameBytes, encoding: .utf8)
                
                endpoints.append(SinglePoint(address: address, bluetoothName: name ?? "", connectionState: state))
                
                i += nameLength
                remaining -= (1 + length)
            }
        }
        
        return Multipoint(endpoints: endpoints)
    }
}
