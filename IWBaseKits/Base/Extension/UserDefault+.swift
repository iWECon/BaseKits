//
//  UserDefault+.swift
//  IWBaseKits
//
//  Created by 未来 on 2019/4/3.
//  Copyright © 2019 iWECon. All rights reserved.
//

#if os(macOS)
    import Cocoa
#else
    import UIKit
#endif


public extension UserDefaults {
    
    subscript(key: String) -> Any? {
        get { return object(forKey: key) }
        set { set(newValue, forKey: key) }
    }
    
    func string(forKey key: String) -> String? {
        return object(forKey: key) as? String
    }
    
    /// (传入字典自动存储, 返回同步结果 可忽略返回值).
    @discardableResult
    func set(with keyValues: [String: Any?]) -> Bool {
        keyValues.forEach({ UserDefaults.standard.setValue($0.value, forKey: $0.key) })
        return UserDefaults.standard.synchronize()
    }
}
