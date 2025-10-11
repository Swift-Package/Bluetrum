//
//  DeviceInfoRequest.swift
//  DeviceManager
//
//  Created by Bluetrum.
//  

import Foundation

// MARK: - 获取设备信息请求
public final class DeviceInfoRequest: Request {
    
    private var payload: Data = Data()
    
    public init() {
        super.init(Command.COMMAND_DEVICE_INFO)
    }
    
    public override init(_ info: UInt8) {
        super.init(Command.COMMAND_DEVICE_INFO)
        requireInfo(info)
    }
    
    @discardableResult
    public func requireInfo(_ info: UInt8) -> Self {
        payload.append(info)
        payload.append(0)
        return self
    }
    
    private static let infosToRequest = [
        INFO_DEVICE_POWER,
        INFO_FIRMWARE_VERSION,
        INFO_BLUETOOTH_NAME,
        INFO_EQ_SETTING,
        INFO_KEY_SETTINGS,
        INFO_DEVICE_VOLUME,
        INFO_PLAY_STATE,
        INFO_WORK_MODE,
        INFO_IN_EAR_STATUS,
        INFO_LANGUAGE_SETTING,
        INFO_AUTO_ANSWER,
        INFO_ANC_MODE,
        INFO_IS_TWS,
        INFO_TWS_CONNECTED,
        INFO_LED_SWITCH,
        INFO_FW_CHECKSUM,
        INFO_ANC_GAIN,
        INFO_TRANSPARENCY_GAIN,
        INFO_ANC_GAIN_NUM,
        INFO_TRANSPARENCY_GAIN_NUM,
        INFO_ALL_EQ_SETTINGS,
        INFO_MAIN_SIDE,
        INFO_PRODUCT_COLOR,
        INFO_SPATIAL_AUDIO_MODE,
        INFO_MULTIPOINT_STATUS,
        INFO_MULTIPOINT_INFO,
        INFO_VOICE_RECOGNITION,
        INFO_ANC_FADE_STATUS,
        INFO_BASS_ENGINE_STATUS,
        INFO_BASS_ENGINE_VALUE,
        INFO_BASS_ENGINE_RANGE,
        INFO_ANTI_WIND_NOISE,
        INFO_DEVICE_CAPABILITIES,
    ]
    
    public func requireDevicePower() -> DeviceInfoRequest {
        requireInfo(Command.INFO_DEVICE_POWER)
    }
    
    public func requireFirmwareVersion() -> DeviceInfoRequest {
        requireInfo(Command.INFO_FIRMWARE_VERSION)
    }
    
    public func requireBluetoothName() -> DeviceInfoRequest {
        requireInfo(Command.INFO_BLUETOOTH_NAME)
    }
    
    public func requireEqSettings() -> DeviceInfoRequest {
        requireInfo(Command.INFO_EQ_SETTING)
    }
    
    public func requireKeySettings() -> DeviceInfoRequest {
        requireInfo(Command.INFO_KEY_SETTINGS)
    }
    
    public func requireDeviceVolume() -> DeviceInfoRequest {
        requireInfo(Command.INFO_DEVICE_VOLUME)
    }
    
    public func requirePlayState() -> DeviceInfoRequest {
        requireInfo(Command.INFO_PLAY_STATE)
    }
    
    public func requireWorkMode() -> DeviceInfoRequest {
        requireInfo(Command.INFO_WORK_MODE)
    }
    
    public func requireInEarStatus() -> DeviceInfoRequest {
        requireInfo(Command.INFO_IN_EAR_STATUS)
    }
    
    public func requireLanguageSetting() -> DeviceInfoRequest {
        requireInfo(Command.INFO_LANGUAGE_SETTING)
    }
    
    public func requireAutoAnswer() -> DeviceInfoRequest {
        requireInfo(Command.INFO_AUTO_ANSWER)
    }
    
    public func requireAncMode() -> DeviceInfoRequest {
        requireInfo(Command.INFO_ANC_MODE)
    }
    
    public func requireIsTws() -> DeviceInfoRequest {
        requireInfo(Command.INFO_IS_TWS)
    }
    
    public func requireTwsConnected() -> DeviceInfoRequest {
        requireInfo(Command.INFO_TWS_CONNECTED)
    }
    
    public func requireLedSwitch() -> DeviceInfoRequest {
        requireInfo(Command.INFO_LED_SWITCH)
    }
    
    public func requireFwChecksum() -> DeviceInfoRequest {
        requireInfo(Command.INFO_FW_CHECKSUM)
    }
    
    public func requireAncGain() -> DeviceInfoRequest {
        requireInfo(Command.INFO_ANC_GAIN)
    }
    
    public func requireTransparencyGain() -> DeviceInfoRequest {
        requireInfo(Command.INFO_TRANSPARENCY_GAIN)
    }
    
    public func requireAncGainNum() -> DeviceInfoRequest {
        requireInfo(Command.INFO_ANC_GAIN_NUM)
    }
    
    public func requireTransparencyGainNum() -> DeviceInfoRequest {
        requireInfo(Command.INFO_TRANSPARENCY_GAIN_NUM)
    }
    
    public func requireAllEqSettings() -> DeviceInfoRequest {
        requireInfo(Command.INFO_ALL_EQ_SETTINGS)
    }
    
    public func requireMainSide() -> DeviceInfoRequest {
        requireInfo(Command.INFO_MAIN_SIDE)
    }
    
    public func requireProductColor() -> DeviceInfoRequest {
        requireInfo(Command.INFO_PRODUCT_COLOR)
    }
    
    @available(*, deprecated, message: "Use requireSpatialAudioMode() instead.")
    public func requireSoundEffect3d() -> DeviceInfoRequest {
        requireInfo(Command.INFO_SOUND_EFFECT_3D)
    }
    
    public func requireSpatialAudioMode() -> DeviceInfoRequest {
        requireInfo(Command.INFO_SPATIAL_AUDIO_MODE)
    }
    
    public func requireBassStatus() -> DeviceInfoRequest {
        requireInfo(Command.INFO_BASS_ENGINE_STATUS)
    }
    
    public func requireBassValue() -> DeviceInfoRequest {
        requireInfo(Command.INFO_BASS_ENGINE_VALUE)
    }
    
    public func requireAntiWindNoise() -> DeviceInfoRequest {
        requireInfo(Command.INFO_ANTI_WIND_NOISE)
    }
    
    public func requireDeviceCapabilities() -> DeviceInfoRequest {
        requireInfo(Command.INFO_DEVICE_CAPABILITIES)
    }
    
    public func requireMaxPacketSize() -> DeviceInfoRequest {
        requireInfo(Command.INFO_MAX_PACKET_SIZE)
    }
    
    public static var defaultInfoRequest: DeviceInfoRequest {
        let request = DeviceInfoRequest()
        DeviceInfoRequest.infosToRequest.forEach {
            request.requireInfo($0)
        }
        return request
    }
    
    public override func getPayload() -> Data { payload }
    
}
