//
//  ResponseMerger.swift
//  DeviceManager
//
//  Created by Bluetrum.
//  

import Foundation

public enum ResponseError {
    case wrongSequenceNumber
    case packetInfoMismatch
    case frameSequenceMismatch
}

protocol ResponseMergerDelegate: AnyObject {
    func didReceiveNotification(_ notification: Notification)
    func didReceiveResponse(_ response: Response)
    func onError(_ error: ResponseError)
}

// MARK: - 数据包重组器工具类
class ResponseMerger {
    
    weak var delegate: ResponseMergerDelegate?
    
    private var buffer: Data
    
    private var totalFrame: Int?
    private var currentCommand: UInt8?
    private var currentCommandType: UInt8?
    private var expectedIndex: Int
    
    init() {
        self.buffer = Data()
        self.totalFrame = nil
        self.currentCommand = 0
        self.currentCommandType = 0
        self.expectedIndex = 0
    }
    
    func merge(command: UInt8, commandType: UInt8, payload: Data, total: Int, index: Int) -> Bool {
        // 如果totalFrame为空，则说明开始新一包
        if totalFrame == nil {
            // 新的一包index必须从0开始
            if index != 0 {
                print("Wrong index number: Expected 0, but got \(total)")
                delegate?.onError(.wrongSequenceNumber)
                return false
            }
            totalFrame = total
            currentCommand = command
            currentCommandType = commandType
            expectedIndex = 0
        } else {
            // 判断是否丢包是否错包（命令、类型、total
            if currentCommand != command
                && currentCommandType != commandType
                && totalFrame != total {
                print("""
                      Merge response packet error (cmd, cmdType, total): Expected \
                      (\(String(describing: currentCommand)), \(String(describing: currentCommandType)), \(String(describing: totalFrame))), \
                      but got (\(command), \(commandType), \(total))
                """)
                delegate?.onError(.packetInfoMismatch)
                reset()
                return false
            }
            
            if expectedIndex != index {
                print("Frame seq mismatch: Expected \(expectedIndex), but got parameter \(index)")
                delegate?.onError(.frameSequenceMismatch)
                reset()
                return false
            }
        }
        
        buffer.append(payload)
        
        // 已经是最后一包
		if let totalFrame = totalFrame, index == totalFrame - 1 {
            let payload = buffer
            // 判断Notify需要满足命令和命令类型两个条件
            if commandType == Command.COMMAND_TYPE_NOTIFY {
                let notification = Notification(command, commandData: payload)
                delegate?.didReceiveNotification(notification)
            }
            // Response只需要判断命令类型
            else if commandType == Command.COMMAND_TYPE_RESPONSE {
                let response = Response(command, commandData: payload)
                delegate?.didReceiveResponse(response)
            }
            reset()
            return true
        }
        
        expectedIndex &+= 1
        
        return true
    }
    
    func reset() {
        buffer = Data()
        totalFrame = nil
        currentCommand = nil
        currentCommandType = nil
        expectedIndex = 0
    }
}
