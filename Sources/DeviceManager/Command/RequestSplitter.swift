//
//  RequestSplitter.swift
//  DeviceManager
//
//  Created by Bluetrum.
//  

import Foundation

class RequestSplitter {
    
    var maxPayloadSize: Int
    
    init(maxPayloadSize: Int) {
        self.maxPayloadSize = maxPayloadSize
    }
    
    func getFragNum(payloadLength: Int) -> Int {
        return (payloadLength + maxPayloadSize - 1) / maxPayloadSize
    }
    
    func chunk(payload: Data, index: Int) -> Data {
        let offset = index * maxPayloadSize
        let length = min(maxPayloadSize, payload.count - offset)
        
        if length <= 0 {
            return Data()
        } else if length == payload.count {
            return payload
        } else {
            return payload.subdata(in: 0..<length)
        }
    }
    
}
