//
//  OtaRequestGenerator.swift
//  FOTA
//
//  Created by Bluetrum.
//  

import Foundation

class OtaRequestGenerator {
    
    var dataProvider: OtaDataProvider?
    
    init(dataProvider: OtaDataProvider?) {
        self.dataProvider = dataProvider
    }
    
    func getOtaStartRequest() -> OtaStartRequest {
        guard let dataProvider = dataProvider else {
            fatalError("dataProvider is nil")
        }
        let startAddress = dataProvider.startAddress
        let dataLen = dataProvider.getTotalLengthToBeSent()
        let data = dataProvider.getStartData(headerSize: 4 + 4) // sizeof(startAddress) + sizeof(dataLen)
        return OtaStartRequest(startAddress: startAddress, dataLen: dataLen, data: data)
    }
    
    func getOtaSendDataRequest() -> OtaSendDataRequest {
        guard let dataProvider = dataProvider else {
            fatalError("dataProvider is nil")
        }
        let data = dataProvider.getDataToBeSent(headerSize: 0)
        return OtaSendDataRequest(data)
    }
    
}
