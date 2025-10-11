//
//  DeviceBeaconV1.swift
//  DeviceManager
//
//  Created by Bluetrum on 2022/5/27.
//

import Foundation

public class DeviceBeaconV1: EarbudsBeacon {
    
    public static let BeaconLen = 13
    
    public static let BeaconLen2 = 9
    
    public var leftCharging: Bool!
    public var leftBatteryLevel: Int!
    public var rightCharging: Bool!
    public var rightBatteryLevel: Int!
    public var caseCharging: Bool!
    public var caseBatteryLevel: Int!

    public override init(data: Data) {
        super.init(data: data)
        // 接着处理父类没处理的信息数据
        
        // Bluetooth classic address
        var ca: Data = Data(count: 6)
        byteBuffer.get(&ca)
        self.btAddress = ca.hex
        
//        // FMSK
//        let featureMask: UInt8 = byteBuffer.get()
//        self.needAuth = (featureMask & (1 << 0)) != 0
//        self.connectionState = DeviceConnectionState(rawValue: (featureMask >> 2) & 3)!
//        
//        // Battery
//        let leftBattery: UInt8 = byteBuffer.get()
//        self.leftCharging = (leftBattery & 0x80) != 0
//        self.leftBatteryLevel = Int(leftBattery & 0x7F)
//        let rightBattery: UInt8 = byteBuffer.get()
//        self.rightCharging = (rightBattery & 0x80) != 0
//        self.rightBatteryLevel = Int(rightBattery & 0x7F)
//        let caseBattery: UInt8 = byteBuffer.get()
//        self.caseCharging = (caseBattery & 0x80) != 0
//        self.caseBatteryLevel = Int(caseBattery & 0x7F)
    }
    
    public override var description: String {
        return """
               DeviceBeaconV1: beaconVersion=\(beaconVersion), productId=\(productId), brandId=\(brandId), \
               btAddress=\(btAddress ?? "--"), \
               needAuth=\(needAuth ?? false), connectionState=\(connectionState ?? .disconnected), \
               leftBattery=(\(leftBatteryLevel ?? 0),\(leftCharging ?? false)), rightBattery=(\(rightBatteryLevel ?? 0),\(rightCharging ?? false)), caseBattery=(\(caseBatteryLevel ?? 0),\(caseCharging ?? false)),
               """
    }
    
}
