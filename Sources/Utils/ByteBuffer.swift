//
//  ByteBuffer.swift
//  AB OTA Demo
//
//  Created by Bluetrum on 2020/12/24.
//

import Foundation

open class ByteBuffer {
    
    public enum Endianness {
        case little
        case big
    }
    
    // MARK: - 将数据包包起来进行处理
    public static func wrap(_ data: Data) -> ByteBuffer {
        let bb = ByteBuffer(size: data.count)
        bb.buffer = [UInt8].init(repeating: 0, count: data.count)
        data.copyBytes(to: &bb.buffer, count: data.count)
        return bb
    }
    
    public static func wrap(_ array: [UInt8]) -> ByteBuffer {
        let data = Data(array)
        return wrap(data)
    }
    
    // MARK: - 数据包容器
    private var buffer = [UInt8]()
    private var currentIndex: Int = 0

    private var currentEndianness: Endianness = .little
    private let hostEndianness: Endianness = OSHostByteOrder() == OSLittleEndian ? .little : .big
    
    // MARK: - 初始化
    public init(size: Int) {
        buffer.reserveCapacity(size)
    }
    
    // MARK: - 获取当前索引的值，并且索引后移
    public func get() -> UInt8 {
        let result = buffer[currentIndex]
        currentIndex += 1
        return result
    }
    
    public var remainning: Int {
        buffer.count - position
    }
    
    public var position: Int {
        get {
            currentIndex
        }
        set {
            currentIndex = newValue
        }
    }
    
    // MARK: - 将数据读到目标数据数组中
    public func get(_ dst: inout Data) {
        for i in 0..<dst.count {
            dst[i] = get()
        }
    }
    
    public func allocate(_ size: Int) {
        buffer = [UInt8]()
        buffer.reserveCapacity(size)
        currentIndex = 0
    }

    public func nativeByteOrder() -> Endianness {
        return hostEndianness
    }

    public func currentByteOrder() -> Endianness {
        return currentEndianness
    }

    public func order(_ endianness: Endianness) -> ByteBuffer {
        currentEndianness = endianness
        return self
    }
    
    public func array() -> [UInt8] {
        return buffer
    }
    
    public func data() -> Data {
        return Data(buffer)
    }
    
    public func hasRemaining() -> Bool { currentIndex < buffer.count }
    
    public func rewind() {
        position = 0
    }
    
    @discardableResult
    public func put<T: FixedWidthInteger>(_ value: T) -> ByteBuffer {
        if currentEndianness == .little {
            buffer.append(contentsOf: to(value.littleEndian))
            return self
        }

        buffer.append(contentsOf: to(value.bigEndian))
        return self
    }

    @discardableResult
    public func put(_ value: Float) -> ByteBuffer {
        if currentEndianness == .little {
            buffer.append(contentsOf: to(value.bitPattern.littleEndian))
            return self
        }

        buffer.append(contentsOf: to(value.bitPattern.bigEndian))
        return self
    }

    @discardableResult
    public func put(_ value: Double) -> ByteBuffer {
        if currentEndianness == .little {
            buffer.append(contentsOf: to(value.bitPattern.littleEndian))
            return self
        }

        buffer.append(contentsOf: to(value.bitPattern.bigEndian))
        return self
    }
    
    @discardableResult
    public func put(_ value: Data) -> ByteBuffer {
        buffer.append(contentsOf: value)
        return self
    }
    
    @discardableResult
    public func put(_ value: [UInt8]) -> ByteBuffer {
        let data = Data(value)
        buffer.append(contentsOf: data)
        return self
    }
    
    @discardableResult
    public func put(_ value: [Int8]) -> ByteBuffer {
        let unsigneds = value.map { UInt8(bitPattern: $0) }
        let data = Data(unsigneds)
        buffer.append(contentsOf: data)
        return self
    }

    public func get(_ index: Int) -> UInt8 {
        return buffer[index]
    }
    
    public func get<T: FixedWidthInteger>() -> T {
        let result = from(Array(buffer[currentIndex..<currentIndex + MemoryLayout<T>.size]), T.self)
        currentIndex += MemoryLayout<T>.size
        return currentEndianness == .little ? result.littleEndian : result.bigEndian
    }
    
    public func get<T: FixedWidthInteger>(_ index: Int) -> T {
        let result = from(Array(buffer[index..<index + MemoryLayout<T>.size]), T.self)
        return currentEndianness == .little ? result.littleEndian : result.bigEndian
    }

    public func getFloat() -> Float {
        let result = from(Array(buffer[currentIndex..<currentIndex + MemoryLayout<UInt32>.size]), UInt32.self)
        currentIndex += MemoryLayout<UInt32>.size
        return currentEndianness == .little ? Float(bitPattern: result.littleEndian) : Float(bitPattern: result.bigEndian)
    }

    public func getFloat(_ index: Int) -> Float {
        let result = from(Array(buffer[index..<index + MemoryLayout<UInt32>.size]), UInt32.self)
        return currentEndianness == .little ? Float(bitPattern: result.littleEndian) : Float(bitPattern: result.bigEndian)
    }

    public func getDouble() -> Double {
        let result = from(Array(buffer[currentIndex..<currentIndex + MemoryLayout<UInt64>.size]), UInt64.self)
        currentIndex += MemoryLayout<UInt64>.size
        return currentEndianness == .little ? Double(bitPattern: result.littleEndian) : Double(bitPattern: result.bigEndian)
    }

    public func getDouble(_ index: Int) -> Double {
        let result = from(Array(buffer[index..<index + MemoryLayout<UInt64>.size]), UInt64.self)
        return currentEndianness == .little ? Double(bitPattern: result.littleEndian) : Double(bitPattern: result.bigEndian)
    }
    
    public func get(_ dst: inout Data, offset: Int, length: Int) {
        for i in 0..<length {
            dst[offset + i] = get()
        }
    }

    private func to<T>(_ value: T) -> [UInt8] {
        var value = value
        return withUnsafeBytes(of: &value, Array.init)
    }

    private func from<T>(_ value: [UInt8], _: T.Type) -> T {
        return value.withUnsafeBytes {
            $0.load(fromByteOffset: 0, as: T.self)
        }
    }
}
