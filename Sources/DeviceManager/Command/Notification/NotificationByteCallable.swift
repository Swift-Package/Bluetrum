//
//  NotificationByteCallable.swift
//  DeviceManager
//
//  Created by Bluetrum on 2022/3/3.
//

import Foundation

@available(*, deprecated, message: "Use class inheriting from 'PayloadHandler'.")
public final class NotificationByteCallable: AbstractNotificationCallable {
    
    public override func callAsFunction() -> Any? {
        if payload.count == 1 {
            return payload[0]
        }
        return nil
    }
    
}
