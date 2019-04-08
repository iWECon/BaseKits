//
//  Common.swift
//  IWBaseKits
//
//  Created by 未来 on 2019/4/3.
//  Copyright © 2019 iWECon. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

public struct Common {
    private init() { }
    
    static let isDebugMode: Bool = {
        #if DEBUG
            return true
        #else
            return false
        #endif
    }()
    
    static var currentViewController: UIViewController? {
        return GetCurrentViewController
    }
    
    public struct Screen {
        private init() { }
        
        static let bounds = UIScreen.main.bounds
        static let size = Screen.bounds.size
        static let width = Screen.size.width
        static let height = Screen.size.height
        
        static let scale = UIScreen.main.scale
        
    }
    
    public struct Device {
        private init() { }
        
        public static let version = UIDevice.current.systemVersion
        
        public static let iPhone: Bool = IWDevice.iPhone
        public static let iPad: Bool = IWDevice.iPad
        
        public static let platform = IWDevice.current.systemName
        public static let aboutName = IWDevice.current.name
        
        public static let localPhoneModel = IWDevice.current.localizedModel
    }
    
    public struct Platform {
        private init() { }
        
        public static let isSimulator: Bool = {
            var isSim = false
            #if arch(i386) || arch(x86_64)
                isSim = true
            #endif
            return isSim
        }()
        
    }
    
    public struct Queue {
        private init() { }
        
        /// (单例, DispatchQueue.once).
        static func once(token: String, block: @escaping () -> Void) -> Void {
            DispatchQueue.once(token: token, block: block)
        }
        
        /// (主线程执行, DispatchQueue.main.async).
        static func main(_ task: @escaping () -> Void) -> Void {
            if Thread.isMainThread {
                task()
            } else {
                DispatchQueue.main.async { task() }
            }
        }
        
        /// (子线程执行, DispatchQueue(label: qlabel).async { }).
        ///
        /// - Parameters:
        ///   - qlabel: 子线程标识
        static func subThread(label qlabel: String, _ task: @escaping () -> Void) -> Void {
            DispatchQueue(label: qlabel).async { task() }
        }
    }
    
    public struct Assert {
        private init() { }
        
        static func failure(_ condition: Bool, msg message: String) -> Void {
            if condition {
                assertionFailure(message)
            }
        }
    }
    
    public struct Delay {
        private init() { }
        
        typealias Task = (_ cancel: Bool) -> Void
        /// Running.
        @discardableResult
        static func execution(delay dly: TimeInterval, toRun task: @escaping () -> ()) -> Task? {
            func dispatch_later(block: @escaping ()->()) {
                let t = DispatchTime.now() + dly
                DispatchQueue.main.asyncAfter(deadline: t, execute: block)
            }
            var closure: (() -> Void)? = task
            var result: Task?
            
            let delayedClosure: Task = { cancel in
                if let internalClosure = closure {
                    if (cancel == false) { DispatchQueue.main.async(execute: internalClosure) }
                }
                closure = nil; result = nil
            }
            
            result = delayedClosure
            
            dispatch_later { if let delayedClosure = result { delayedClosure(false) } }
            return result
        }
        /// (取消延迟执行的任务 (执行开始前使用)).
        static func cancel(_ task: Task?) {
            task?(true)
        }
        
    }
}

// MARK:- 正则操作符
/// 正则操作符号
infix operator =~
/// (正则操作, 左边参数为文本, 右边参数为表达式).
public func =~ (content: String, matchs: String) -> Bool {
    return IWRegex.match(matchs, content)
}


public func MakeSize(_ width: CGFloat, _ height: CGFloat) -> IWSize {
    return IWSize.init(width: width, height: height)
}
public func MakeRect(_ x: CGFloat, _ y: CGFloat, _ width: CGFloat, _ height: CGFloat) -> CGRect {
    return CGRect.init(x: x, y: y, width: width, height: height)
}
public func MakePoint(_ x: CGFloat, _ y: CGFloat) -> CGPoint {
    return CGPoint.init(x: x, y: y)
}


// MARK:- Constant
public let NavBarHeight  : CGFloat = IWDevice.isShaped ? 88.0 : 64.0
public let TopSpacing    : CGFloat = IWDevice.isShaped ? 24.0 : 0.0
public let TabBarHeight  : CGFloat = IWDevice.isShaped ? 83.0 : 49.0
public let BottomSpacing : CGFloat = IWDevice.isShaped ? 34.0 : 0.0
public let ScreenBounds  : CGRect  = Common.Screen.bounds
public let ScreenSize    : CGSize  = Common.Screen.size
public let ScreenHeight  : CGFloat = Common.Screen.height
public let ScreenWidth   : CGFloat = Common.Screen.width
