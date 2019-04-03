//
//  Color+.swift
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

public extension CGColor {
    
    #if !os(macOS)
    var uiColor: UIColor {
        return UIColor.init(cgColor: self)
    }
    #endif
    
    #if os(macOS)
    var nsColor: NSColor {
        return NSColor.init(cgColor: self)
    }
    #endif
}
