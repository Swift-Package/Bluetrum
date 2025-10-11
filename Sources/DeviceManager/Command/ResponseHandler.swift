//
//  ResponseHandler.swift
//  DeviceManager
//
//  Created by Bluetrum.
//

import Foundation
import Utils

protocol ResponseHandlerDelegate: AnyObject {
    func didReceiveNotification(_ notification: Notification)
    func didReceiveResponse(_ response: Response)
    func onError(_ error: ResponseError)
}

// MARK: - 处理外设回复的数据包分离器工具类
class ResponseHandler {
    
    private static let HEAD_SIZE = 5
    
    private var expectedSeqNum: UInt8
    private let merger: ResponseMerger
    
    weak var delegate: ResponseHandlerDelegate?
    
    // MARK: - 初始化响应处理器
    convenience init() {
        self.init(merger: ResponseMerger())
    }
    
    init(merger: ResponseMerger) {
        expectedSeqNum = 0
        self.merger = merger
        merger.delegate = self
    }
    
    // MARK: - 处理 DeviceManager 收到的数据包(简单拆包后交给数据包重组器 ResponseMerger 处理并通过委托接收重组器发上来的数据)
    func handleFrameData(_ frameData: Data) {
        DispatchQueue.global().async {
            // 检查包结构，按照结构拆包
            // （如果不符合条件，先不记录SeqNum）
            if frameData.count > ResponseHandler.HEAD_SIZE {
                let bb = ByteBuffer.wrap(frameData)
                let byte0 = bb.get()
                let seqNum = byte0 & 0xF// 数据包由 0 -> 15 递增循环使用
                
                if seqNum == self.expectedSeqNum {
                    self.expectedSeqNum = (self.expectedSeqNum + 1) & 0xF
                    
                    let cmd = bb.get()                          // 取出 Cmd (哪条命令)
                    let cmdType = bb.get()                      // 取出命令类型 1: Reques 2: Response 3: Notify(主动上报的数据不需要对端回复)
                    let byte3 = bb.get()                        // 取出 帧序号 和 总帧数
                    let frameSeq = byte3 & 0xF                  // Bit0 ～ Bit3 帧序号 0~15 循环使用
                    let totalFrame = ((byte3 >> 4) & 0xF) + 1   // 总帧数 1~16
                    let frameLen = bb.get()                     // 取出 本帧数据Payload 长度
                    
                    // Check payload length
                    if frameLen == bb.remainning {
                        var payload = Data(count: Int(frameLen))
                        bb.get(&payload)
                        print("Received frame: cmd=\(cmd) cmdType=\(cmdType) frameSeq=\(frameSeq) totalFrame=\(totalFrame) frameLen=\(frameLen) payload=\(payload.hex)")
                        let _ = self.merger.merge(command: cmd, commandType: cmdType, payload: payload, total: Int(totalFrame), index: Int(frameSeq))
                    } else {
                        print("The length of payload mismatch: Expected \(frameLen) but got \(bb.remainning)")
                    }
                } else {
                    print("Frame seq mismatch: Expected \(self.expectedSeqNum) but got \(seqNum)")
                    self.expectedSeqNum = (seqNum + 1) & 0xF
                }
            } else {
                print("The length of received data is too short")
            }
        }
    }
    
    func reset() {
        expectedSeqNum = 0
        merger.reset()
    }
}

// MARK: - 接收数据包重组器发上来的数据再抛给 DeviceCommManager
extension ResponseHandler: ResponseMergerDelegate {
    func didReceiveNotification(_ notification: Notification) {
        delegate?.didReceiveNotification(notification)
    }
    
    func didReceiveResponse(_ response: Response) {
        delegate?.didReceiveResponse(response)
    }
    
    func onError(_ error: ResponseError) {
        delegate?.onError(error)
    }
}
