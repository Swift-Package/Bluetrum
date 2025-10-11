//
//  FirmwareChecksumPayloadHandler.swift
//  DeviceManager
//
//  Created by Bluetrum on 2022/3/7.
//

import Foundation

public final class FirmwareChecksumPayloadHandler: AbstractPayloadHandler {
    
    public override func callAsFunction() -> Any? {
        
        if payload.count == 4 {
            var checksum = Data(count: 4)
            // Big endian to Little endian
            checksum[0] = payload[3]
            checksum[1] = payload[2]
            checksum[2] = payload[1]
            checksum[3] = payload[0]
            return checksum
        }
        return nil
    }
    
}
