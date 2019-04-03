//
//  Console.swift
//  IWBaseKits
//
//  Created by 未来 on 2019/3/28.
//  Copyright © 2019 iWECon. All rights reserved.
//

import UIKit
import CocoaLumberjack

public struct Console {
    private init() {}
    
    /// Use in Appdelegate-> didFinished
    static func initialize() -> Void {
        DDLog.sharedInstance.add(DDTTYLogger.sharedInstance)
        _infos()
    }
    
    private static func _infos() -> Void {
        self.log("""
日志初始化成功...
------- 本次运行设备信息
版本型号: \(Common.Device.aboutName), \(IWDevice.modelName), \(Common.Device.platform) \(Common.Device.version), \(IWDevice.modelIdentifier)
设计尺寸(W*H): \(Common.Screen.size)
物理尺寸(W*H): (\(Common.Screen.width * Common.Screen.scale), \(Common.Screen.height * Common.Screen.scale))
是否越狱: \(IWDevice.isJailbroken ? "是" : "否")
""")
    }
    
    static func log(_ str: String?) -> Void {
        self.verbose(str ?? "")
    }
    
    static func debug(_ str: String?) -> Void {
        DDLogDebug("💚 DEBUG:\n" + (str ?? ""))
    }
    
    static func info(_ str: String?) -> Void {
        DDLogInfo("💙 INFO:\n" + (str ?? ""))
    }
    
    static func verbose(_ str: String?) -> Void {
        DDLogVerbose("💜 VERBOSE:\n" + (str ?? ""))
    }
    
    static func error(_ str: String?) -> Void {
        DDLogError("❤️ ERROR:\n" + (str ?? ""))
    }
    
    static func warn(_ str: String?) -> Void {
        DDLogWarn("💛 WARN:\n" + (str ?? ""))
    }
    
    
}
