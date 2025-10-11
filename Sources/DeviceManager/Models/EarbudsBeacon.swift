//
//  EarbudsBeacon.swift
//  DeviceManager
//
//  Created by Bluetrum on 2022/5/27.
//

import Foundation

public enum DeviceConnectionState: UInt8 {
    case disconnected   = 0
    case connected      = 1
}

/// Abstract Class
public class EarbudsBeacon: DeviceBeacon {
    
    public var btAddress: String!
    
    public var needAuth: Bool!
    public var supportCTKD: Bool = false
    public var connectionState: DeviceConnectionState!
    public var isConnected: Bool { connectionState == .connected }
    public var useCustomSppUuid: Bool = false // Unused in iOS
    
    public override init(data: Data) {
        super.init(data: data)
        // 接着处理父类没处理的信息数据
        // Implement in subclass
    }
    
    public override var description: String {
        return """
               EarbudsBeacon: beaconVersion=\(beaconVersion), productId=\(productId), brandId=\(brandId), \
               btAddress=\(btAddress!), \
               supportCTKD=\(supportCTKD), needAuth=\(needAuth!), connectionState=\(connectionState!)
               """
    }
    
}
