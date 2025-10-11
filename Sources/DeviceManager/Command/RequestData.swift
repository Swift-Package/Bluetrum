//
//  RequestData.swift
//  DeviceManager
//
//  Created by Bluetrum on 2022/3/29.
//

import Foundation

public class RequestData {
    
    public let data: Data
    public let writeWithResponse: Bool
    
    public init(_ data: Data, writeWithResponse: Bool) {
        self.data = data
        self.writeWithResponse = writeWithResponse
    }
    
}
