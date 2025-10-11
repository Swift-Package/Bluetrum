//
//  OtaInfo.swift
//  FOTA
//
//  Created by Bluetrum.
//  

import Foundation
import Utils

final class OtaInfo {
    
    let startAddress: UInt32
    let blockSize: UInt32
    let allowUpdate: Bool
    
    init?(_ data: Data) {
        guard data.count == 9 else {
            return nil
        }
        self.startAddress = data.read(fromOffset: 0)
        self.blockSize = data.read(fromOffset: 4)
        self.allowUpdate = data.read(fromOffset: 8) as UInt8 == 0x01
    }
}

extension OtaInfo: CustomStringConvertible {
    
    var description: String {
        return "startAddress:\(startAddress), blockSize:\(blockSize), allowUpdate:\(allowUpdate)"
    }
}
