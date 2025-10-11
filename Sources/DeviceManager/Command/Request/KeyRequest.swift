//
//  KeyRequest.swift
//  DeviceManager
//
//  Created by Bluetrum.
//  

import Foundation

public enum KeyType: UInt8 {
    case leftSingleTap      = 0x01
    case rightSingleTap     = 0x02
    case leftDoubleTap      = 0x03
    case rightDoubleTap     = 0x04
    case leftTripleTap      = 0x05
    case rightTripleTap     = 0x06
    case leftLongPress      = 0x07
    case rightLongPress     = 0x08
}

public enum KeyFunction: UInt8 {
    case none               = 0x00
    case recall             = 0x01
    case assistant          = 0x02
    case previous           = 0x03
    case next               = 0x04
    case volumeUp           = 0x05
    case volumeDown         = 0x06
    case playPause          = 0x07
    case gameMode           = 0x08
    case ancMode            = 0x09
}

public final class KeyRequest: TlvRequest {
    
    public private(set) var keyType: KeyType
    public private(set) var keyFunction: KeyFunction
    
    public init(keyType: KeyType, keyFunction: KeyFunction) {
        self.keyType = keyType
        self.keyFunction = keyFunction
        super.init(Command.COMMAND_KEY)
    }
    
    public override func getTlvObjectDict() -> [UInt8 : Any?] {
        [
            keyType.rawValue: keyFunction.rawValue,
        ]
    }
    
    public static func LeftSingleTapKeyRequest(keyFunction: KeyFunction) -> KeyRequest {
        KeyRequest(keyType: .leftSingleTap, keyFunction: keyFunction)
    }
    
    public static func RightSingleTapKeyRequest(keyFunction: KeyFunction) -> KeyRequest {
        KeyRequest(keyType: .rightSingleTap, keyFunction: keyFunction)
    }
    
    public static func LeftDoubleTapKeyRequest(keyFunction: KeyFunction) -> KeyRequest {
        KeyRequest(keyType: .leftDoubleTap, keyFunction: keyFunction)
    }
    
    public static func RightDoubleTapKeyRequest(keyFunction: KeyFunction) -> KeyRequest {
        KeyRequest(keyType: .rightDoubleTap, keyFunction: keyFunction)
    }
    
    public static func LeftTripleTapKeyRequest(keyFunction: KeyFunction) -> KeyRequest {
        KeyRequest(keyType: .leftTripleTap, keyFunction: keyFunction)
    }
    
    public static func RightTripleTapKeyRequest(keyFunction: KeyFunction) -> KeyRequest {
        KeyRequest(keyType: .rightTripleTap, keyFunction: keyFunction)
    }
    
    public static func LeftLongPressKeyRequest(keyFunction: KeyFunction) -> KeyRequest {
        KeyRequest(keyType: .leftLongPress, keyFunction: keyFunction)
    }
    
    public static func RightLongPressKeyRequest(keyFunction: KeyFunction) -> KeyRequest {
        KeyRequest(keyType: .rightLongPress, keyFunction: keyFunction)
    }
    
}
