//
//  SinglePoint.swift
//  DeviceManager
//
//  Created by Bluetrum on 2023/6/12.
//

import Foundation
import Observation

// MARK: - 多设备连接报告的设备信息列表单个设备项
//@Observable
//@DebugDescription
public final class SinglePoint: Identifiable {
	
	public var id: String {
		return address
	}
	
	// MARK: - 外部可绑定连接状态 - YJY
	public var isConnectedBind: Bool = false
	
	public var isConnected: Bool {
		return connectionState == SinglePoint.CONNECTION_STATE_CONNECTED
	}
	
    var debugDescription: String {
        return "SinglePoint { address: \(_address), bluetoothName: \(bluetoothName), connectionState: \(connectionState) }"
    }
    
    public static let CONNECTION_STATE_DISCONNECTED: UInt8  = 0
    public static let CONNECTION_STATE_CONNECTED: UInt8     = 1
    
    private var _address: Data
    public private(set) var bluetoothName: String
    private var connectionState: UInt8
    
    public init(address: Data, bluetoothName: String, connectionState: UInt8) {
        self._address = address
        self.bluetoothName = bluetoothName
        self.connectionState = connectionState
		self.isConnectedBind = connectionState == SinglePoint.CONNECTION_STATE_CONNECTED
    }
    
    public var addressBytes: Data {
        return _address
    }
    
    public var address: String {
        return String(format: "%02X:%02X:%02X:%02X:%02X:%02X", _address[0], _address[1], _address[2], _address[3], _address[4], _address[5])
    }
}
