//
//  OtaStateNotificationCallable.swift
//  FOTA
//
//  Created by Bluetrum.
//  

import Foundation
import DeviceManager

public final class OtaStateNotificationCallable: AbstractPayloadHandler {
    
    public override func callAsFunction() -> Any? {
        if payload.count == 1 {
            return payload[0]
        }
        return nil
    }
    
}
