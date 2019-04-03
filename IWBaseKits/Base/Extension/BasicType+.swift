//
//  BasicType+.swift
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

protocol BasicTypeable {
    var string: String { get }
}

extension BasicTypeable {
    var string: String {
        return "\(self)"
    }
}

extension CGFloat: BasicTypeable { }
extension Float: BasicTypeable { }
extension Int: BasicTypeable { }

public extension CGFloat {
    
    var float: Float {
        return Float(self)
    }
    
    static let min = CGFloat.leastNormalMagnitude
    static let max = CGFloat.greatestFiniteMagnitude
}


public extension Float {
    
    var cgFloat: CGFloat {
        return CGFloat(self)
    }
    
    static let min = Float.leastNormalMagnitude
    static let max = Float.greatestFiniteMagnitude
}


public extension Int {
    
    var float: Float {
        return Float(self)
    }
    
    var cgFloat: CGFloat {
        return CGFloat(self)
    }
    
    /// (返回一个 0 ..< self 的区间).
    var countableRange: CountableRange<Int> {
        return 0 ..< self
    }
    /// (返回一个 0 ... self 的区间).
    var closeRange: ClosedRange<Int> {
        return 0 ... self
    }
    
    /// (随机取一个从 from - to 之间的数)
    static func random(from: Int = 0, to: Int) -> Int {
        guard from < to else { return 0 }
        return Int(arc4random() % UInt32(to)) + from
    }
    static var random: Int {
        return Int(arc4random() % 100) + 1
    }
    
    /// (是否为质数).
    ///     质数定义为在大于1的自然数中，除了1和它本身以外不再有其他因数。
    var isPrime: Bool {
        if self == 2 { return true }
        guard self > 1, self % 2 != 0 else { return false }
        
        let base = Int(sqrt(Double(self)))
        for i in Swift.stride(from: 3, through: base, by: 2) where self % i == 0 {
            return false
        }
        return true
    }
}
