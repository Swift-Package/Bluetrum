//
//  OtaError.swift
//  AB OTA Demo
//
//  Created by Bluetrum on 2020/12/25.
//

import Foundation

/// 升级过程中的错误，`OtaManagerDelegate`代理方法`onError`中使用
public enum OTAError: Error {
    
    /// 蓝牙未打开
    case centralManagerNotPoweredOn

    /// 设备不支持蓝讯FOTA升级
    case deviceNotSupported
    /// 设备已经关闭
    case deviceClosed
    /// 设备拒绝升级
    case refusedByDevice
    /// 没有FOTA数据可用
    case noDataAvailable
    
    /// 设备报告错误，含错误代码
    case deviceReport(code: UInt8)
    
    /// 等待设备回复超时
    case timeoutWaitingResponse
}

extension OTAError: LocalizedError {
    
    /// 错误描述
    public var errorDescription: String? {
        switch self {
        case .centralManagerNotPoweredOn: return "error_central_manager_not_powered_on".localized
        case .deviceNotSupported: return "error_device_not_support".localized
        case .deviceClosed: return "error_device_closed".localized
        case .refusedByDevice: return "error_refused_by_device".localized
        case .noDataAvailable: return "error_no_ota_data_available".localized
        case .deviceReport(let code): return String(format: "error_device_report_error_code".localized, code)
        case .timeoutWaitingResponse: return "error_wait_response_timeout".localized
        }
    }
    
}
