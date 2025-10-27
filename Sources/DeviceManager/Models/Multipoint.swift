//
//  Multipoint.swift
//  DeviceManager
//
//  Created by Bluetrum on 2023/6/12.
//

import Foundation

// MARK: - 多设备连接报告的设备信息列表
//@Observable
//@DebugDescription
public final class Multipoint {
    
    var debugdescription: String {
        "Multipoint(endpoints: \(endpoints))"
    }
    
    public let endpoints: [SinglePoint]
    
    public init(endpoints: [SinglePoint]) {
        self.endpoints = endpoints
    }
}
