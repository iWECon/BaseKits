//
//  Error+.swift
//  IWBaseKits
//
//  Created by 未来 on 2019/4/3.
//  Copyright © 2019 iWECon. All rights reserved.
//

import UIKit

extension Error {
    
    /// (self as NSError).code
    public var code: Int {
        return (self as NSError).code
    }
    
}
