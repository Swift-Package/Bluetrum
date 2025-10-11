//
//  ABDevice.swift
//  ABMateDemo
//
//  Created by Bluetrum.
//  

import Foundation
import CoreBluetooth
import DequeModule

public protocol ConnectionStateCallback: AnyObject {
    func onConnected(device: ABDevice)
    func onReceiveAuthResult(device: ABDevice, passed: Bool)
}

public protocol DeviceDataDelegate: AnyObject {
    func onReceiveData(_ data: Data)
}

public enum AuthenticationState {
    case idle
    case waitResponse
    case waitResult
    case pass
    case notPass
}

/**
 Base Device class, used as an abstract class.
 */
open class ABDevice: NSObject, DeviceCommDelegate {
    
    open weak var connectionStateCallback: ConnectionStateCallback?
    open weak var dataDelegate: DeviceDataDelegate?
    
    public var peripheral: CBPeripheral
    
    public private(set) var name: String?
    public private(set) var featureVersion: Int
    public private(set) var productId: Int
    
    public var rssi: Int? {
        didSet {
            if rssi == 127 {
                rssi = oldValue
            }
        }
    }
    
    public var rssiPercent: Int? {
        if let rssi = rssi {
            return Int(100.0 * (127.0 + Double(rssi)) / (127.0 + 20.0))
        } else {
            return nil
        }
    }
    
    open var isConnected: Bool { false }
    open var supportCTKD: Bool { false }
    
    // MARK: - Public API
    public init(peripheral: CBPeripheral, deviceBeacon: DeviceBeacon) {
        self.peripheral = peripheral
        self.name = peripheral.name
        self.featureVersion = deviceBeacon.beaconVersion
        self.productId = deviceBeacon.productId
        super.init()
    }
    
    open func updateDeviceStatus(deviceBeacon: DeviceBeacon) {
        // Implement in subclass
    }
    
    open func connect() {
        // Implement in subclass
    }
    
    open func startAuth() {
        // Implement in subclass
    }
    
    open func sendRequestData(_ requestData: RequestData) {
        // Implement in subclass
    }
    
    open func stop() {
        // Implement in subclass
    }
    
    open func triggerCTKD() {
        // Implement in subclass
    }
}
