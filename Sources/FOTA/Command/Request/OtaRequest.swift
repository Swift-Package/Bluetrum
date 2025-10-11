//
//  OtaRequest.swift
//  FOTA
//
//  Created by Bluetrum.
//  

import Foundation
import DeviceManager

public class OtaRequest: Request {
    
    public static let COMMAND_OTA_GET_INFO: UInt8  = 0xA0
    public static let COMMAND_OTA_START: UInt8     = 0xA1
    public static let COMMAND_OTA_SEND_DATA: UInt8 = 0xA2
    public static let COMMAND_OTA_STATE: UInt8     = 0xA3
    
    public override var leWriteWithResponse: Bool { false }
    
}
