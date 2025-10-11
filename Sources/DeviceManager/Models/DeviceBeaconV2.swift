//
//  DeviceBeaconV2.swift
//  DeviceManager
//
//  Created by Bluetrum on 2022/5/27.
//

import Foundation

public class DeviceBeaconV2: EarbudsBeacon {
    
    public static let BeaconLen = 13
    
    public static let BeaconLen2 = 9
    
    public override init(data: Data) {
        super.init(data: data)
        // 接着处理父类没处理的信息数据
        
        // Bluetooth classic address
        var ca: Data = Data(count: 6)
        byteBuffer.get(&ca)
        ca = deobfuscateBtAddress(data: ca)
        self.btAddress = ca.hex
        
        // FMSK
        let featureMask: UInt8 = byteBuffer.get()
        self.needAuth = (featureMask & (1 << 0)) != 0
        self.supportCTKD = (featureMask & (1 << 1)) != 0
        self.connectionState = DeviceConnectionState(rawValue: (featureMask >> 2) & 3)!
        self.useCustomSppUuid = (featureMask & (1 << 4)) != 0
        
        // BID
        brandId = 2//Int((byteBuffer.get() as UInt8)
                   //   | (byteBuffer.get() as UInt8) << 8
                   //   | (byteBuffer.get() as UInt8) << 16)
    }
    
    private func deobfuscateBtAddress(data: Data) -> Data {
        return Data(data.map { $0 ^ 0xAD })
    }
    
    public override var description: String {
        return """
               DeviceBeaconV2: beaconVersion=\(beaconVersion), productId=\(productId), brandId=\(brandId), \
               btAddress=\(btAddress!), \
               supportCTKD=\(supportCTKD), needAuth=\(needAuth!), connectionState=\(connectionState!)
               """
    }
    
}
