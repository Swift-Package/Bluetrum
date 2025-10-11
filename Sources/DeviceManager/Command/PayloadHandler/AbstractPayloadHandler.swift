//
//  AbstractPayloadHandler.swift
//  DeviceManager
//
//  Created by Bluetrum on 2022/3/7.
//

import Foundation

// MARK: - 抽象数据包处理类
open class AbstractPayloadHandler: PayloadHandler {
    
    public private(set) var payload: Data
    
    public required init(_ payload: Data) {
        self.payload = payload
    }
    
    open func callAsFunction() -> Any? {
        fatalError("Implement in subclass")
    }
}
