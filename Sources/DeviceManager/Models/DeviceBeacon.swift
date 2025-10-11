//
//  DeviceBeacon.swift
//  DeviceManager
//
//  Created by Bluetrum.
//  

import Foundation
import Utils

// MARK: - 设备信息广播模型
public class DeviceBeacon: CustomStringConvertible {
    
    var byteBuffer: ByteBuffer!
    
    public let beaconVersion: Int
    public let productId: Int
    
    public internal(set) var brandId: Int = 0
    
    public var AgentId: Int {
        return brandId >> 16
    }
    
    public init(data: Data) {
        byteBuffer = ByteBuffer.wrap(data)
            .order(.little)
        
        // Features
        let features: UInt8 = byteBuffer.get()
        // Beacon Version
        self.beaconVersion = Int(features & 0xF)
        // Product ID
        self.productId = Int(byteBuffer.get() as UInt16)
        
        // 剩下的不同子类不同，需要在子类中处理
    }
    
    public var description: String {
        return """
               DeviceBeacon: beaconVersion=\(beaconVersion), productId=\(productId), brandId=\(brandId)
               """
    }
    
}

public extension DeviceBeacon {
    
    static func isDeviceBeacon(data: Data) -> Bool {
        // 广播包版本1和2没有其他的鉴别方法，只能通过长度识别
        return (data.count == DeviceBeaconV1.BeaconLen && getDeviceBeaconVersion(data: data) == 1)
            || (data.count == DeviceBeaconV2.BeaconLen && getDeviceBeaconVersion(data: data) == 2)
    }
    
    static func isDeviceBeacon2(data: Data) -> Bool {
        // 广播包版本1和2没有其他的鉴别方法，只能通过长度识别
        //return (data.count == DeviceBeaconV1.BeaconLen2 && getDeviceBeaconVersion(data: data) == 1)
        //    || (data.count == DeviceBeaconV2.BeaconLen2 && getDeviceBeaconVersion(data: data) == 2)
        
        let _ = (data.count == DeviceBeaconV1.BeaconLen2 && getDeviceBeaconVersion(data: data) == 1)
        || (data.count == DeviceBeaconV2.BeaconLen2 && getDeviceBeaconVersion(data: data) == 2)
        
        
        return true
    }
    
    static func getDeviceBeaconVersion(data: Data) -> Int {
        return Int(data[0] & 0x0F)
    }
    
    static func getDeviceBeacon(data: Data) -> DeviceBeacon? {
        if isDeviceBeacon(data: data) {
            let beaconVersion = getDeviceBeaconVersion(data: data)
            if beaconVersion == 1 {
                return DeviceBeaconV1(data: data)
            } else if beaconVersion == 2 {
                return DeviceBeaconV2(data: data)
            }
        }
        return nil
    }
    
    static func getDeviceBeacon2(data: Data) -> DeviceBeacon? {
        
        if isDeviceBeacon2(data: data) {
            let beaconVersion = getDeviceBeaconVersion(data: data)
            
            if beaconVersion == 1 {
                return DeviceBeaconV1(data: data)
            } else if beaconVersion == 2 {
                return DeviceBeaconV2(data: data)
            }
            
            var data2 = Data();
            
            data2.append(data)
            data2.insert(0, at: data2.count)
            data2.insert(0, at: data2.count)
            
            return DeviceBeaconV2(data: data2)
            
        }
        
        return nil
    }
    
}
