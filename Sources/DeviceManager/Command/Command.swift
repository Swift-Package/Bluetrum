//
//  Command.swift
//  DeviceManager
//
//  Created by Bluetrum.
//  

import Foundation

// MARK: - 命令与响应协议
open class Command: CommandProtocol {
    
	// MARK: - 这三个用来标记收到的回复是什么类型的数据包决定用哪个代码通道路径进行处理
    public static let COMMAND_TYPE_REQUEST: UInt8       = 1
    public static let COMMAND_TYPE_RESPONSE: UInt8      = 2
    public static let COMMAND_TYPE_NOTIFY: UInt8        = 3
    
	// MARK: - 下面是支持的内置命令
    public static let COMMAND_EQ: UInt8                 = 0x20
    public static let COMMAND_MUSIC_CONTROL: UInt8      = 0x21
    public static let COMMAND_KEY: UInt8                = 0x22
    public static let COMMAND_AUTO_SHUTDOWN: UInt8      = 0x23
    public static let COMMAND_FACTORY_RESET: UInt8      = 0x24
    public static let COMMAND_WORK_MODE: UInt8          = 0x25
    public static let COMMAND_IN_EAR_DETECT: UInt8      = 0x26// 入耳检测开关
    public static let COMMAND_DEVICE_INFO: UInt8        = 0x27// 获取设备信息指令
    public static let COMMAND_NOTIFY: UInt8             = 0x28
    public static let COMMAND_LANGUAGE: UInt8           = 0x29
    public static let COMMAND_FIND_DEVICE: UInt8        = 0x2A
    public static let COMMAND_AUTO_ANSWER: UInt8        = 0x2B
    @available(*, deprecated, message: "Use COMMAND_ANC.")
    public static let COMMAND_ANC_MODE: UInt8           = 0x2C// 降噪模式命令(旧版)
    public static let COMMAND_BLUETOOTH_NAME: UInt8     = 0x2D
    public static let COMMAND_LED_MODE: UInt8           = 0x2E
    public static let COMMAND_CLEAR_PAIR_RECORD: UInt8  = 0x2F// 清除配对记录
    @available(*, deprecated, message: "Use COMMAND_ANC.")
    public static let COMMAND_ANC_GAIN: UInt8           = 0x30
    @available(*, deprecated, message: "Use COMMAND_ANC.")
    public static let COMMAND_TRANSPARENCY_GAIN: UInt8  = 0x31
    public static let COMMAND_SOUND_EFFECT_3D: UInt8    = 0x32
    public static let COMMAND_SPATIAL_AUDIO_MODE: UInt8 = 0x32
    public static let COMMAND_MULTIPOINT: UInt8         = 0x33// 多设备连接命令
    public static let COMMAND_VOICE_RECOGNITION: UInt8  = 0x34
    public static let COMMAND_ANC: UInt8                = 0x35// 降噪模式命令(新版)
    public static let COMMAND_BASS_ENGINE: UInt8        = 0x36
    public static let COMMAND_ANTI_WIND_NOISE: UInt8    = 0x37
    
	// MARK: - 下面是设备信息INFO通道类型(比如0x09表示0x27命令回复的TLV中0x09为入耳检测开关的状态)
    public static let INFO_DEVICE_POWER: UInt8          = 0x01// 设备电量
    public static let INFO_FIRMWARE_VERSION: UInt8      = 0x02// 固件版本
    public static let INFO_BLUETOOTH_NAME: UInt8        = 0x03
    public static let INFO_EQ_SETTING: UInt8            = 0x04
    public static let INFO_KEY_SETTINGS: UInt8          = 0x05
    public static let INFO_DEVICE_VOLUME: UInt8         = 0x06// 设备音量
    public static let INFO_PLAY_STATE: UInt8            = 0x07
    public static let INFO_WORK_MODE: UInt8             = 0x08
    public static let INFO_IN_EAR_STATUS: UInt8         = 0x09// 入耳检测状态
    public static let INFO_LANGUAGE_SETTING: UInt8      = 0x0A// 提示音语言类型
    public static let INFO_AUTO_ANSWER: UInt8           = 0x0B
    public static let INFO_ANC_MODE: UInt8              = 0x0C// 降噪模式
    public static let INFO_IS_TWS: UInt8                = 0x0D
    public static let INFO_TWS_CONNECTED: UInt8         = 0x0E
    public static let INFO_LED_SWITCH: UInt8            = 0x0F
    public static let INFO_FW_CHECKSUM: UInt8           = 0x10
    public static let INFO_ANC_GAIN: UInt8              = 0x11// 降噪强度
    public static let INFO_TRANSPARENCY_GAIN: UInt8     = 0x12
    public static let INFO_ANC_GAIN_NUM: UInt8          = 0x13
    public static let INFO_TRANSPARENCY_GAIN_NUM: UInt8 = 0x14
    public static let INFO_ALL_EQ_SETTINGS: UInt8       = 0x15// EQ全部预设
    public static let INFO_MAIN_SIDE: UInt8             = 0x16
    public static let INFO_PRODUCT_COLOR: UInt8         = 0x17// 产品颜色
    public static let INFO_SOUND_EFFECT_3D: UInt8       = 0x18
    public static let INFO_SPATIAL_AUDIO_MODE: UInt8    = 0x18// INFO_SOUND_EFFECT_3D
    public static let INFO_MULTIPOINT_STATUS: UInt8     = 0x19// 多设备连接状态
    public static let INFO_MULTIPOINT_INFO: UInt8       = 0x1A// 多设备连接
    public static let INFO_VOICE_RECOGNITION: UInt8     = 0x1C
    public static let INFO_ANC_FADE_STATUS: UInt8       = 0x1D
    public static let INFO_BASS_ENGINE_STATUS: UInt8    = 0x1E
    public static let INFO_BASS_ENGINE_VALUE: UInt8     = 0x1F
    public static let INFO_BASS_ENGINE_RANGE: UInt8     = 0x20
    public static let INFO_ANTI_WIND_NOISE: UInt8       = 0x21// 防风噪
    public static let INFO_DEVICE_CAPABILITIES:UInt8    = 0xFE
    public static let INFO_MAX_PACKET_SIZE: UInt8       = 0xFF
    
	// MARK: - 下面是设备信息NOTIFICATION通道类型
    public static let NOTIFICATION_DEVICE_POWER: UInt8      = 0x01
    public static let NOTIFICATION_EQ_SETTING: UInt8        = 0x04
    public static let NOTIFICATION_KEY_SETTINGS: UInt8      = 0x05
    public static let NOTIFICATION_DEVICE_VOLUME: UInt8     = 0x06
    public static let NOTIFICATION_PLAY_STATE: UInt8        = 0x07
    public static let NOTIFICATION_WORK_MODE: UInt8         = 0x08
    public static let NOTIFICATION_IN_EAR_STATUS: UInt8     = 0x09// 入耳检测
    public static let NOTIFICATION_LANGUAGE_SETTING: UInt8  = 0x0A
    public static let NOTIFICATION_ANC_MODE: UInt8          = 0x0C
    public static let NOTIFICATION_TWS_CONNECTED: UInt8     = 0x0E
    public static let NOTIFICATION_LED_SWITCH: UInt8        = 0x0F
    public static let NOTIFICATION_ANC_GAIN: UInt8          = 0x11
    public static let NOTIFICATION_TRANSPARENCY_GAIN: UInt8 = 0x12
    public static let NOTIFICATION_MAIN_SIDE: UInt8         = 0x16
    public static let NOTIFICATION_SOUND_EFFECT_3D: UInt8   = 0x18
    public static let NOTIFICATION_SPATIAL_AUDIO_MODE: UInt8    = 0x18// NOTIFICATION_SOUND_EFFECT_3D
    public static let NOTIFICATION_MULTIPOINT_STATUS: UInt8     = 0x19
    public static let NOTIFICATION_MULTIPOINT_INFO: UInt8       = 0x1A
    public static let NOTIFICATION_MULTIPOINT_EVENT: UInt8      = 0x1B
    public static let NOTIFICATION_VOICE_RECOGNITION: UInt8     = 0x1C
    public static let NOTIFICATION_BASS_ENGINE_STATUS: UInt8    = 0x1E
    public static let NOTIFICATION_ANTI_WIND_NOISE: UInt8       = 0x21
    
    open func getCommand() -> UInt8 { 0 }
    
    open func getCommandType() -> UInt8 { 0 }
    
    open func getPayload() -> Data { Data() }
}
