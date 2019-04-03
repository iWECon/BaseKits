//
//  Dictionary+.swift
//  IWBaseKits
//
//  Created by 未来 on 2019/4/3.
//  Copyright © 2019 iWECon. All rights reserved.
//

import UIKit

public extension Dictionary {
    
    subscript (safe key: Key) -> Value? {
        return self.keys.contains(key) ? self[key] : nil
    }
    
    func has(key: Key) -> Bool {
        return index(forKey: key) != nil
    }
}
