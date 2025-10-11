//
//  NotificationDataCallable.swift
//  DeviceManager
//
//  Created by Bluetrum on 2022/3/3.
//

import Foundation

@available(*, deprecated, message: "Use class inheriting from 'PayloadHandler'.")
public final class NotificationDataCallable: AbstractNotificationCallable {
    
    public override func callAsFunction() -> Any? {
        return payload
    }
    
}
