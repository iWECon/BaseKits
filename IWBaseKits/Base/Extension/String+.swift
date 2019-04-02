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
    
}

extension String {
    
    /// Check if the value meets the conditions(process)
    ///
    /// - Parameter process: Check process.
    /// - Returns: Bool
    func check(_ process: (String) -> Bool) -> Bool {
        return process(self)
    }
    
}
