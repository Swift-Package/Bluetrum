//
//  RequestHandler.swift
//  DeviceManager
//
//  Created by Bluetrum.
//  

import Foundation
import DequeModule
import Utils

class RequestHandler {
    
    static let DEFAULT_PAYLOAD_SIZE: Int = 20    // 基础MTU 23字节，除开包头3字节
    
    private static let HEAD_SIZE: Int = 5
    
    private let splitter: RequestSplitter
    
    private var hostSeqNum: UInt8
    
    var maxPayloadSize: Int {
        get {
            splitter.maxPayloadSize
        }
        set {
            splitter.maxPayloadSize = newValue - RequestHandler.HEAD_SIZE
        }
    }
    
    init(splitter: RequestSplitter) {
        self.splitter = splitter
        self.hostSeqNum = 0
    }
    
    convenience init() {
        self.init(splitter: RequestSplitter(maxPayloadSize: RequestHandler.DEFAULT_PAYLOAD_SIZE - RequestHandler.HEAD_SIZE))
    }
    
    func reset() {
        hostSeqNum = 0
    }
    
    // MARK: - Handler
    
    func handleRequest(_ request: Request) -> Deque<RequestData> {
        let commandData = request.getPayload()
        let dataLength = commandData.count
        
        var commandQueue: Deque<RequestData> = Deque()
        
        // 先处理不拆包
        if dataLength == 0 {
            let byte3: UInt8 = 0
            
            let bb = ByteBuffer(size: RequestHandler.HEAD_SIZE)
            bb.put(hostSeqNum)
            bb.put(request.getCommand())
            bb.put(request.getCommandType())
            bb.put(byte3)
            bb.put(0 as UInt8)
            commandQueue.append(RequestData(bb.data(), writeWithResponse: request.leWriteWithResponse))
            
            hostSeqNum = (hostSeqNum + 1) & 0xF
        } else {
            let fragNum = splitter.getFragNum(payloadLength: dataLength)
            for i in 0..<fragNum {
                let payload = splitter.chunk(payload: commandData, index: i)
                let payloadLength = payload.count
                let byte3 = UInt8((((fragNum - 1) << 4) & 0xF0) | (i & 0xF))
                
                let bb = ByteBuffer(size: RequestHandler.HEAD_SIZE + payloadLength)
                bb.put(hostSeqNum)
                bb.put(request.getCommand())
                bb.put(request.getCommandType())
                bb.put(byte3)
                bb.put(UInt8(payloadLength))
                bb.put(payload)
                commandQueue.append(RequestData(bb.data(), writeWithResponse: request.leWriteWithResponse))
                
                hostSeqNum = (hostSeqNum + 1) & 0xF
            }
        }
        
        return commandQueue
    }
    
}
