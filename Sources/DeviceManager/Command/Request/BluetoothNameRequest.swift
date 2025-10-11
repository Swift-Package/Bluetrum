//
//  BluetoothNameRequest.swift
//  DeviceManager
//
//  Created by Bluetrum.
//  

import Foundation

public final class BluetoothNameRequest: Request {
    
    public private(set) var bluetoothName: String
    
    public init(_ bluetoothName: String) {
        self.bluetoothName = bluetoothName
        super.init(Command.COMMAND_BLUETOOTH_NAME)
    }
    
    public override func getPayload() -> Data {
        if let nameData = bluetoothName.data(using: .utf8) {
            return nameData
        }
        return super.getPayload()
    }
    
}
