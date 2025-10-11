//
//  AbstractDeviceInfoCallable.swift
//  DeviceManager
//
//  Created by Bluetrum.
//  

import Foundation

@available(*, deprecated, message: "Use class inheriting from 'PayloadHandler'.")
open class AbstractDeviceInfoCallable: DeviceInfoCallable {
    
    public private(set) var payload: Data
    
    public required init(_ payload: Data) {
        self.payload = payload
    }
    
    open func callAsFunction() -> Any? {
        fatalError("Implement in subclass")
    }
    
}
