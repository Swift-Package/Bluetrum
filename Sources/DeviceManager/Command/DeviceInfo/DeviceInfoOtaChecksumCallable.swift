//
//  DeviceInfoOtaChecksumCallable.swift
//  DeviceManager
//
//  Created by Bluetrum.
//  

import Foundation

@available(*, deprecated, message: "Use class inheriting from 'PayloadHandler'.")
public final class DeviceInfoOtaChecksumCallable: AbstractDeviceInfoCallable {
    
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
