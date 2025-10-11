//
//  OtaInfoRequest.swift
//  FOTA
//
//  Created by Bluetrum.
//  

import Foundation
import Utils

public class OtaInfoRequest: OtaRequest {
    
    let payload: Data
    
    init(version: UInt32, hashData: Data, dataSize: UInt32) {
        var payload = Data()
        payload += version
        payload += hashData
        payload += dataSize
        self.payload = payload
        super.init(OtaRequest.COMMAND_OTA_GET_INFO)
    }
    
    public override func getPayload() -> Data {
        return payload
    }
    
}
