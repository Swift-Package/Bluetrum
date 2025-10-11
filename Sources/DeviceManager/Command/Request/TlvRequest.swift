//
//  TlvRequest.swift
//  DeviceManager
//
//  Created by Bluetrum on 2023/6/10.
//

import Foundation

open class TlvRequest: Request {
    
    public private(set) var tlvDataDic = [UInt8: Data]()
    public private(set) var preGeneratedPayload: Data = Data()
    
    public override init(_ command: UInt8) {
        super.init(command)
        
        // invoke before use get preGeneratedPayload
        generatePayload()
    }
    
    open func getTlvObjectDict() -> [UInt8: Any?] {
        fatalError("Implement in subclass")
    }
    
    open func objectToData(_ object: Any) -> Data? {
        switch object {
        case let value as UInt8: return Data([value])
        case let value as Bool: return Data([value ? 1 : 0])
        case let value as [UInt8]: return Data(value)
        case let value as Data: return value
        default: return nil
        }
    }
    
    open func generatePayload() {
        let tlvObjectDict = getTlvObjectDict()
        // [UInt8: Any?]转成[UInt8:Data]，同时过滤掉不支持的情况
        tlvDataDic = tlvObjectDict.reduce(into: [UInt8:Data](), { partialResult, entry in
            // 排除value为null，排除不支持，无法转换成byte[]的情况
            if let obj = entry.value, let data = objectToData(obj) {
                partialResult.updateValue(data, forKey: entry.key)
            }
        })
        preGeneratedPayload = generateTlvData(entries: tlvDataDic)
    }
    
    open func generateTlvData(entries: [UInt8: Data]) -> Data {
        var data = Data()
        for entry in entries {
            data.append(contentsOf: [entry.key])
            data.append(contentsOf: [UInt8(entry.value.count)])
            data.append(entry.value)
        }
        return data
    }
    
    public override func getPayload() -> Data {
        return preGeneratedPayload
    }
}

public extension TlvRequest {
    var emptyData: Data {
        Data()
    }
}
