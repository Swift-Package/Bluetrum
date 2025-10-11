//
//  OtaDataDefinition.swift
//  AB OTA Demo
//
//  Created by Bluetrum on 2020/12/29.
//

import Foundation

enum OtaState: UInt8 {
    case STATE_OK               = 0x00
    case STATE_PAUSE            = 0xFD
    case STATE_CONTINUE         = 0xFE
    case STATE_DONE             = 0xFF
}
