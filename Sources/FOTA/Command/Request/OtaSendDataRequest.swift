//
//  OtaSendDataRequest.swift
//  FOTA
//
//  Created by Bluetrum.
//  

import Foundation

public class OtaSendDataRequest: OtaRequest {
    
    let payload: Data
    
    init(_ data: Data) {
        self.payload = data
        super.init(OtaRequest.COMMAND_OTA_SEND_DATA)
    }
    
    public override func getPayload() -> Data {
        return payload
    }
    
}
