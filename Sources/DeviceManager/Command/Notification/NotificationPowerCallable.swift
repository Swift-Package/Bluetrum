//
//  NotificationPowerCallable.swift
//  DeviceManager
//
//  Created by Bluetrum on 2022/3/3.
//

import Foundation

@available(*, deprecated, message: "Use class inheriting from 'PayloadHandler'.")
public final class NotificationPowerCallable: AbstractNotificationCallable {
    
    public override func callAsFunction() -> Any? {
        if payload.count != 0 {
            return DevicePower(powerData: payload)
        }
        return nil
    }
    
}
