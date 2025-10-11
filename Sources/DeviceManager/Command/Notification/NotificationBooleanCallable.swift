//
//  NotificationBooleanCallable.swift
//  DeviceManager
//
//  Created by Bluetrum on 2022/3/3.
//

import Foundation

@available(*, deprecated, message: "Use class inheriting from 'PayloadHandler'.")
public final class NotificationBooleanCallable: AbstractNotificationCallable {
    
    public override func callAsFunction() -> Any? {
        
        if payload.count == 1 {
            let value = payload[0]
            if value == 0x00 {
                return false
            } else if value == 0x01 {
                return true
            }
        }
        return nil
    }
    
}
