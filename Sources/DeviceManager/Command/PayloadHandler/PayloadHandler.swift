//
//  DataHandler.swift
//  DeviceManager
//
//  Created by Bluetrum on 2022/3/4.
//

import Foundation

/// 用以替代DeviceInfoCallable和NotificationCallable，统一Payload数据处理
public protocol PayloadHandler {
    
    var payload: Data { get }
    
    init(_ payload: Data)
    
    func callAsFunction() -> Any?
    
}
