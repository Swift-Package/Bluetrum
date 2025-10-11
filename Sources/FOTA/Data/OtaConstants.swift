//
//  Constants.swift
//  AB OTA Demo
//
//  Created by Bluetrum on 2020/12/25.
//

import Foundation

final class OtaConstants {
    
    public static let DEFAULT_MTU_SIZE: UInt16      = 23
    
    public static let DEFAULT_PACKET_SIZE: UInt16   = DEFAULT_MTU_SIZE - 3
    
    public static let DEFAULT_BLOCK_SIZE: UInt32    = 4 * 1024
    
    public static let UNDEFINED_BLOCK_SIZE: UInt32  = UInt32.max    // 0xFFFFFFFF
    
}
