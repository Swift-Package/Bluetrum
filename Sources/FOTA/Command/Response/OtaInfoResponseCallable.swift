//
//  OtaInfoResponseCallable.swift
//  FOTA
//
//  Created by Bluetrum.
//  

import Foundation
import DeviceManager

public final class OtaInfoResponseCallable: AbstractPayloadHandler {
    
    public override func callAsFunction() -> Any? {
        return OtaInfo(payload)
    }
    
}
