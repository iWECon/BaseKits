//
//  IWDevice.swift
//  IWBaseKits
//
//  Created by 未来 on 2019/4/3.
//  Copyright © 2019 iWECon. All rights reserved.
//

import UIKit

public class IWDevice: UIDevice {
    
    public static let iPad: Bool = {
        return UIDevice.current.model == "iPad"
    }()
    
    public static let iPhone: Bool = {
        return UIDevice.current.model == "iPhone"
    }()
    
    /// 是否为异型全面屏 (X, Xs, Xr, Max)
    public static let isShaped: Bool = {
        
        if #available(iOS 11.0, *) {
            let window = AppDelegate.shared.window
            guard window != nil else {
                return false
            }
            return window!.safeAreaInsets.bottom > 0.0
        }
        return false
    }()
    
    private static let examineBreakToolPathes = ["/Applications/Cydia.app",  "/Library/MobileSubstrate/MobileSubstrate.dylib", "/bin/bash", "/usr/sbin/sshd", "/etc/apt"]
    /// (是否越狱).
    public static var isJailbroken: Bool {
        // 1. 是否存在越狱文件
        if examineBreakToolPathes.filter({ FileManager.default.fileExists(atPath: $0) }).count > 0 {
            return true
        }
        // 2. 是否存在 cydia 应用
        if UIApplication.shared.canOpenURL("cydia://".urlValue) {
            return true
        }
        // 3. 是否可以读取所有应用
        if FileManager.default.fileExists(atPath: "/User/Applications/") {
            return true
        }
        // 4. 是否可以读取环境变量
        return (getenv("DYLD_INSERT_LIBRARIES") != nil)
    }
    
}



extension IWDevice {
    
    /// (返回机型内部标识, 例如: iPhone9,1).
    public static var modelIdentifier: String {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        return identifier
    }
    
    /// (返回机型, 例如: iPhone 7).
    public static var modelName: String {
        let identifier = modelIdentifier
        switch identifier {
        case "iPod5,1":                                 return "iPod Touch 5"
        case "iPod7,1":                                 return "iPod Touch 6"
        case "iPhone3,1", "iPhone3,2", "iPhone3,3":     return "iPhone 4"
        case "iPhone4,1":                               return "iPhone 4s"
        case "iPhone5,1", "iPhone5,2":                  return "iPhone 5"
        case "iPhone5,3", "iPhone5,4":                  return "iPhone 5c"
        case "iPhone6,1", "iPhone6,2":                  return "iPhone 5s"
        case "iPhone7,2":                               return "iPhone 6"
        case "iPhone7,1":                               return "iPhone 6 Plus"
        case "iPhone8,1":                               return "iPhone 6s"
        case "iPhone8,2":                               return "iPhone 6s Plus"
        case "iPhone8,4":                               return "iPhone SE"
        case "iPhone9,1":                               return "iPhone 7"
        case "iPhone9,2":                               return "iPhone 7 Plus"
        case "iPhone10,1", "iPhone10,4":                return "iPhone 8"
        case "iPhone10,2", "iPhone10,5":                return "iPhone 8 Plus"
        case "iPhone10,3", "iPhone10,6":                return "iPhone X"
        case "iPhone11,8":                              return "iPhone Xr"
        case "iPhone11,2":                              return "iPhone Xs"
        case "iPhone11,6":                              return "iPhone Xs Max"
            
        case "iPad2,1", "iPad2,2", "iPad2,3", "iPad2,4":return "iPad 2"
        case "iPad3,1", "iPad3,2", "iPad3,3":           return "iPad 3"
        case "iPad3,4", "iPad3,5", "iPad3,6":           return "iPad 4"
        case "iPad4,1", "iPad4,2", "iPad4,3":           return "iPad Air"
        case "iPad5,3", "iPad5,4":                      return "iPad Air 2"
        case "iPad2,5", "iPad2,6", "iPad2,7":           return "iPad Mini"
        case "iPad4,4", "iPad4,5", "iPad4,6":           return "iPad Mini 2"
        case "iPad4,7", "iPad4,8", "iPad4,9":           return "iPad Mini 3"
        case "iPad5,1", "iPad5,2":                      return "iPad Mini 4"
        case "iPad6,7", "iPad6,8":                      return "iPad Pro"
        case "AppleTV5,3":                              return "Apple TV"
        case "i386", "x86_64":                          return "Simulator"
        default:                                        return identifier
        }
    }
    
}
