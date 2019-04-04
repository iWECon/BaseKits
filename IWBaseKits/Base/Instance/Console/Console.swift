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

public struct Console {
    private init() {}
    
    /// Use in Appdelegate-> didFinished
    static func initialize() -> Void {
        DDLog.sharedInstance.add(DDTTYLogger.sharedInstance)
        _infos()
    }
    
    private static func _infos() -> Void {
        self.debug("""
日志初始化成功...
------- 本次运行设备信息
版本型号: \(Common.Device.aboutName), \(IWDevice.modelName), \(Common.Device.platform) \(Common.Device.version), \(IWDevice.modelIdentifier)
设计尺寸(W*H): \(Common.Screen.size)
物理尺寸(W*H): (\(Common.Screen.width * Common.Screen.scale), \(Common.Screen.height * Common.Screen.scale))
是否越狱: \(IWDevice.isJailbroken.yesOrNo)
是否异型全面屏: \(IWDevice.shaped.yesOrNo)
--------
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
