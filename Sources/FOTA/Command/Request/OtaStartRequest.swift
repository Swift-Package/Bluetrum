//
//  OtaStartRequest.swift
//  FOTA
//
//  Created by Bluetrum.
//  

import Foundation
import Utils

public class OtaStartRequest: OtaRequest {
    
    let payload: Data
    
    init(startAddress: UInt32, dataLen: UInt32, data: Data) {
        var payload = Data()
        payload += startAddress
        payload += dataLen
        payload += data
        self.payload = payload
        super.init(OtaRequest.COMMAND_OTA_START)
    }
    
    public override func getPayload() -> Data {
        return payload
    }
    
}
