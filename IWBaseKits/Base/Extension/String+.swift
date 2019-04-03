//
//  String+.swift
//  IWBaseKits
//
//  Created by 未来 on 2019/3/30.
//  Copyright © 2019 iWECon. All rights reserved.
//

import UIKit

extension Optional where Wrapped == String {
    
    /// Check if the value meets the conditions(process)
    ///
    /// - Parameter process: Check process.
    /// - Returns: Bool
    func check(_ process: (String) -> Bool) -> Bool {
        return process(self ?? "")
    }
    
    var url: URL? {
        if self == nil {
            return nil
        }
        return URL.init(string: self!)
    }
    
    var urlValue: URL {
        return url!
    }
}

extension String {
    
    /// Check if the value meets the conditions(process)
    ///
    /// - Parameter process: Check process.
    /// - Returns: Bool
    func check(_ process: (String) -> Bool) -> Bool {
        return process(self)
    }
    
    var url: URL? {
        return URL.init(string: self)
    }
    
    var urlValue: URL {
        return url!
    }
}
