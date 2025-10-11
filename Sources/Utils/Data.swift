//
//  Data.swift
//  Utils
//
//  Created by Bluetrum.
//  

import Foundation
import CommonCrypto

public extension Data {

    // Inspired by: https://stackoverflow.com/a/38024025/2115352

    /// Converts the required number of bytes, starting from `offset`
    /// to the value of return type.
    ///
    /// - parameter offset: The offset from where the bytes are to be read.
    /// - returns: The value of type of the return type.
    /// 从偏移处读取一个目标类型的值
    func read<R: FixedWidthInteger>(fromOffset offset: Int = 0) -> R {
        let length = MemoryLayout<R>.size
        return subdata(in: offset ..< offset + length).withUnsafeBytes { $0.load(as: R.self) }
    }
    
    func readUInt24(fromOffset offset: Int = 0) -> UInt32 {
        return UInt32(self[offset]) | UInt32(self[offset + 1]) << 8 | UInt32(self[offset + 2]) << 16
    }
    
    func readBigEndian<R: FixedWidthInteger>(fromOffset offset: Int = 0) -> R {
        let r: R = read(fromOffset: offset)
        return r.bigEndian
    }
    
}

// Source: http://stackoverflow.com/a/42241894/2115352

public protocol DataConvertible {
    static func + (lhs: Data, rhs: Self) -> Data
    static func += (lhs: inout Data, rhs: Self)
}

public extension DataConvertible {
    
    static func + (lhs: Data, rhs: Self) -> Data {
        var value = rhs
        let data = withUnsafePointer(to: &value) { pointer -> Data in
            return Data(buffer: UnsafeBufferPointer(start: pointer, count: 1))
        }
        return lhs + data
    }
    
    static func += (lhs: inout Data, rhs: Self) {
        lhs = lhs + rhs
    }
    
}

extension UInt8  : DataConvertible { }
extension UInt16 : DataConvertible { }
extension UInt32 : DataConvertible { }
extension UInt64 : DataConvertible { }
extension Int8   : DataConvertible { }
extension Int16  : DataConvertible { }
extension Int32  : DataConvertible { }
extension Int64  : DataConvertible { }

extension Int    : DataConvertible { }
extension UInt   : DataConvertible { }
extension Float  : DataConvertible { }
extension Double : DataConvertible { }

extension String : DataConvertible {
    
    public static func + (lhs: Data, rhs: String) -> Data {
        guard let data = rhs.data(using: .utf8) else { return lhs }
        return lhs + data
    }
    
}

extension Data : DataConvertible {
    
    public static func + (lhs: Data, rhs: Data) -> Data {
        var data = Data()
        data.append(lhs)
        data.append(rhs)
        
        return data
    }
    
    static func + (lhs: Data, rhs: Data?) -> Data {
        guard let rhs = rhs else {
            return lhs
        }
        var data = Data()
        data.append(lhs)
        data.append(rhs)
        
        return data
    }
    
}

extension Bool : DataConvertible {
    
    public static func + (lhs: Data, rhs: Bool) -> Data {
        if rhs {
            return lhs + UInt8(0x01)
        } else {
            return lhs + UInt8(0x00)
        }
    }
    
}

public extension FixedWidthInteger {

    var data: Data {
        var value = self
        return Data(bytes: &value, count: MemoryLayout.size(ofValue: self))
    }

}

public extension Data {
    
    /// Hex string to Data representation
    /// Inspired by https://stackoverflow.com/questions/26501276/converting-hex-string-to-nsdata-in-swift
    init?(hex: String) {
        guard hex.count % 2 == 0 else {
            return nil
        }
        let len = hex.count / 2
        var data = Data(capacity: len)
        
        for i in 0..<len {
            let j = hex.index(hex.startIndex, offsetBy: i * 2)
            let k = hex.index(j, offsetBy: 2)
            let bytes = hex[j..<k]
            if var num = UInt8(bytes, radix: 16) {
                data.append(&num, count: 1)
            } else {
                return nil
            }
        }
        self = data
    }
    
    /// Hexadecimal string representation of `Data` object.
    var hex: String {
        return map { String(format: "%02X", $0) }.joined()
    }
    
    func md5() ->Data {
        let length = Int(CommonCrypto.CC_MD5_DIGEST_LENGTH)
        let messageData = self
        var digestData = Data(count: length)

        _ = digestData.withUnsafeMutableBytes { digestBytes -> UInt8 in
            messageData.withUnsafeBytes { messageBytes -> UInt8 in
                if let messageBytesBaseAddress = messageBytes.baseAddress,
                   let digestBytesBlindMemory = digestBytes.bindMemory(to: UInt8.self).baseAddress {
                    let messageLength = CommonCrypto.CC_LONG(messageData.count)
                    CommonCrypto.CC_MD5(messageBytesBaseAddress, messageLength, digestBytesBlindMemory)
                }
                return 0
            }
        }
        return digestData
    }
    
}
