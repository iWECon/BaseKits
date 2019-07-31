//
//  Array+.swift
//  IWBaseKits
//
//  Created by 未来 on 2019/4/3.
//  Copyright © 2019 iWECon. All rights reserved.
//

#if os(macOS)
import Cocoa
#elseif os(iOS)
import UIKit
#endif

public extension Array {
    
    subscript (safe index: Int) -> Element? {
        return (0 ..< count).contains(index) ? self[index] : nil
    }
    
}

public extension Array where Element: IWView {
    
    func makeObjects(perform selector: Selector) -> Void {
        for element in self {
            if element.responds(to: selector) {
                element.perform(selector)
            }
        }
    }
    
}

public extension Array where Element == Substring {
    
    func mapString() -> [String] {
        return self.map(String.init)
    }
}

public extension Array where Element: Equatable {
    
    func index(of: Element) -> Int {
        var idx = -1
        var founded = false
        for ele in self {
            if ele == of {
                founded = true
                break
            }
            idx += 1
        }
        if founded {
            return idx + 1
        }
        return -1
    }
    
}
