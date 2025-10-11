//
//  NotificationUInt8ToIntCallable.swift
//  DeviceManager
//
//  Created by Bluetrum on 2022/3/4.
//

import Foundation

@available(*, deprecated, message: "Use class inheriting from 'PayloadHandler'.")
public final class NotificationUInt8ToIntCallable: AbstractNotificationCallable {
    
    public override func callAsFunction() -> Any? {
        if payload.count == 1 {
            return Int(Int8(bitPattern: payload[0]))
        }
        return nil
    }
    
}
