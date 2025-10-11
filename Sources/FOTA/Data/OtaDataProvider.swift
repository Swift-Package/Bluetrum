//
//  OtaDataProvider.swift
//  AB OTA Demo
//
//  Created by Bluetrum on 2020/12/24.
//

import Foundation

class OtaDataProvider {
    
    private var otaData: Data
    
    public var blockSize: UInt32        = OtaConstants.UNDEFINED_BLOCK_SIZE
    public var packetSize: UInt16       = OtaConstants.DEFAULT_MTU_SIZE - 3

    private var blockOffset: UInt32     = 0
    private var fileOffset: UInt32      = 0
    
    public var startAddress: UInt32 {
        get {
            return self.fileOffset
        }
        set(address) {
            self.fileOffset = address
        }
    }
    
    public var dataSize: UInt32 { UInt32(otaData.count) }

    public var progress: UInt32 { fileOffset * 100 / dataSize }
    
    
    public init(otaData: Data) {
        self.otaData = otaData
    }
    
    public func reset() {
        self.fileOffset = 0
        self.packetSize = OtaConstants.DEFAULT_MTU_SIZE - 3
        self.blockSize = OtaConstants.UNDEFINED_BLOCK_SIZE
    }
    
    public func isBlockSentFinish() -> Bool {
        if blockSize == OtaConstants.UNDEFINED_BLOCK_SIZE {
            return isAllDataSent()
        } else {
            return (fileOffset - blockOffset == blockSize) || isAllDataSent()
        }
    }
    
    public func isAllDataSent() -> Bool {
        return fileOffset == otaData.count
    }
    
    /* Command */
    
    public func getTotalLengthToBeSent() -> UInt32 {
        // data length
        var sendLen: UInt32
        
        // if no need to split
        if blockSize == OtaConstants.UNDEFINED_BLOCK_SIZE {
            sendLen = UInt32(otaData.count) - fileOffset
        }
        // need splitting
        else {
            // left data length to be sent
            let leftLen = UInt32(otaData.count) - fileOffset
            sendLen = min(leftLen, blockSize)
            blockOffset = fileOffset
        }
        
        return sendLen
    }
    
    public func getStartData(headerSize: UInt8) -> Data {
        let fileSize = UInt32(otaData.count)

        // Limit the length to send
        var dataLen = (blockSize == OtaConstants.UNDEFINED_BLOCK_SIZE) ? fileSize : blockSize
        dataLen = min(dataLen, UInt32(packetSize) - UInt32(headerSize))
        // Check if overlap file
        if fileOffset + dataLen > otaData.count {
            dataLen = fileSize - fileOffset
        }
        
        let data = otaData[fileOffset..<fileOffset+dataLen]
        fileOffset += dataLen
        return data
    }
    
    public func getDataToBeSent(headerSize: UInt8) -> Data {
        let fileSize = UInt32(otaData.count)

        // Limit the length to send
        var dataLen = (blockSize == OtaConstants.UNDEFINED_BLOCK_SIZE) ? fileSize : blockSize
        dataLen = min(dataLen, UInt32(packetSize) - UInt32(headerSize))
        
        // Need splitting
        if blockSize != OtaConstants.UNDEFINED_BLOCK_SIZE {
            // Check if overlap block
            if (fileOffset - blockOffset) + dataLen > blockSize {
                dataLen = blockSize - (fileOffset - blockOffset)
            }
        }
        // Check if overlap file
        if fileOffset + dataLen > fileSize {
            dataLen = fileSize - fileOffset
        }
        
        let data = otaData[fileOffset..<fileOffset+dataLen]
        fileOffset += dataLen
        return data
    }
    
    
}
