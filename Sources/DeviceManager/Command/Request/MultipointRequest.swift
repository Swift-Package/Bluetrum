//
//  MultipointRequest.swift
//  DeviceManager
//
//  Created by Bluetrum on 2023/6/12.
//

import Foundation

public final class MultipointRequest: TlvRequest {
    
    public static let STATUS: UInt8     = 1;
    public static let CONNECT: UInt8    = 2;
    public static let DISCONNECT: UInt8 = 3;
    public static let UNPAIR: UInt8     = 4;
    public static let REPORT: UInt8     = 5;
    
    private(set) var enable: Bool?
    private(set) var addressToConnect: Data?
    private(set) var addressToDisconnect: Data?
    private(set) var addressToUnpair: Data?
    private var addressToReport: Data?
    
    private init(enable: Bool? = nil,
                 addressToConnect: Data? = nil,
                 addressToDisconnect: Data? = nil,
                 addressToUnpair: Data? = nil,
                 addressToReport: Data? = nil) {
        self.enable = enable
        self.addressToConnect = addressToConnect
        self.addressToDisconnect = addressToDisconnect
        self.addressToUnpair = addressToUnpair
        self.addressToReport = addressToReport
        super.init(Command.COMMAND_MULTIPOINT)
    }
    
    public static func enableRequest(enable: Bool) -> MultipointRequest {
        return MultipointRequest(enable: enable)
    }
    
    public static func disableRequest(addressToDisconnect: Data) -> MultipointRequest {
        return MultipointRequest(enable: false, addressToDisconnect: addressToDisconnect)
    }
    
    public static func connectRequest(addressToConnect: Data) -> MultipointRequest {
        return MultipointRequest(addressToConnect: addressToConnect)
    }
    
    public static func disconnectRequest(addressToDisconnect: Data) -> MultipointRequest {
        return MultipointRequest(addressToDisconnect: addressToDisconnect)
    }
    
    public static func unpairRequest(addressToUnpair: Data) -> MultipointRequest {
        return MultipointRequest(addressToUnpair: addressToUnpair)
    }
    
    public static func reportRequest(addressToReport: Data) -> MultipointRequest {
        return MultipointRequest(addressToReport: addressToReport)
    }
    
    public override func getTlvObjectDict() -> [UInt8: Any?] {
        [
            MultipointRequest.STATUS:       enable,
            MultipointRequest.CONNECT:      obfuscateAddress(addressToConnect),
            MultipointRequest.DISCONNECT:   obfuscateAddress(addressToDisconnect),
            MultipointRequest.UNPAIR:       obfuscateAddress(addressToUnpair),
            MultipointRequest.REPORT:       obfuscateAddress(addressToReport),
        ]
    }
    
    private func obfuscateAddress(_ address: Data?) -> Data? {
        guard let address else { return nil }
        
        var result = Data(count: 6)
        for (i, a) in address.enumerated() {
            result[i] = a ^ 0xAD
        }
        return result
    }
}
