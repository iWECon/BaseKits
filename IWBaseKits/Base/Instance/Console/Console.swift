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
