//
//  Console.swift
//  IWBaseKits
//
//  Created by 未来 on 2019/3/28.
//  Copyright © 2019 iWECon. All rights reserved.
//

import UIKit
import CocoaLumberjack
import RxSwift
import RxCocoa
import Localize_Swift

class LogFormatter: DDDispatchQueueLogFormatter {
    let dateFormatter: DateFormatter

    override init() {
        dateFormatter = DateFormatter()
        dateFormatter.formatterBehavior = .behavior10_4
        dateFormatter.dateFormat = "HH:mm:ss.SSS"

        super.init()
    }

    override func format(message logMessage: DDLogMessage) -> String {
        let dateAndTime = dateFormatter.string(from: logMessage.timestamp)
        return "\(dateAndTime): \(logMessage.message)"
    }
}

public struct Console {
    private init() {}
    
    /// Use in Appdelegate-> didFinished
    static func initialize() -> Void {
        
        DDTTYLogger.sharedInstance.logFormatter = LogFormatter()
        DDLog.add(DDTTYLogger.sharedInstance) // 发送到 Xcode 控制台
        // DDLog.add(DDASLLogger.sharedInstance) // 发送到 Console.app for macOS
        
        // 写入到文件
        let fileLogger = DDFileLogger.init()
        fileLogger.rollingFrequency = 60 * 60 * 24; // 刷新频率 24 小时
        fileLogger.logFileManager.maximumNumberOfLogFiles = 7; // 日志保存一周
        DDLog.add(fileLogger)
        
        _infos()
    }
    
    /// 初始化时写出的设备信息
    private static func _infos() -> Void {
        self.debug("""
日志初始化成功...
------------ 本次运行设备信息
     版本型号: \(Common.Device.aboutName), \(IWDevice.modelName), \(Common.Device.platform) \(Common.Device.version), \(IWDevice.modelIdentifier)
设计尺寸(W*H): \(Common.Screen.size)
物理尺寸(W*H): (\(Common.Screen.width * Common.Screen.scale), \(Common.Screen.height * Common.Screen.scale))
     是否越狱: \(IWDevice.isJailbroken.yesOrNo)
是否异型全面屏: \(IWDevice.isShaped.yesOrNo)
 本次运行UUID: \(NSUUID.init().uuidString)
------
     多语言包: \(Localize.availableLanguages(true))
------------
""")
    }
    
    static func log(_ str: String?) -> Void {
        self.verbose(str ?? "")
    }
    
    static func debug(_ item: Any) -> Void {
        DDLogDebug("💚   DEBUG: \(item)")
    }
    
    static func info(_ str: String?) -> Void {
        DDLogInfo("💙    INFO: " + (str ?? ""))
    }
    
    static func verbose(_ str: String?) -> Void {
        DDLogVerbose("💜 VERBOSE: " + (str ?? ""))
    }
    
    static func error(_ str: String?) -> Void {
        DDLogError("❤️   ERROR: " + (str ?? ""))
    }
    
    static func warn(_ str: String?) -> Void {
        DDLogWarn("💛    WARN: " + (str ?? ""))
    }
    
    static func logResourcesCount() -> Void {
//        #if DEBUG
//            self.warn("RxSwift resources count: \(RxSwift.Resources.total)")
//        #endif
    }
}
