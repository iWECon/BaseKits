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
    public static let shaped: Bool = {
        
        if #available(iOS 11.0, *) {
            let window = AppDelegate.shared.window
            guard window != nil else {
                return false
            }
            return window!.safeAreaInsets.bottom > 0.0
        }
        return false
    }()
    
}
