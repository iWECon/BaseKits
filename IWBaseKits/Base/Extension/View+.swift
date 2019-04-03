//
//  View+.swift
//  IWBaseKits
//
//  Created by 未来 on 2019/4/3.
//  Copyright © 2019 iWECon. All rights reserved.
//

#if os(macOS)
    import Cocoa
    public typealias IWView = NSView
#else
    import UIKit
    public typealias IWView = UIView
#endif

import RxSwift

public extension IWView {
    
    var x: CGFloat {
        get { return self.frame.origin.x }
        set { self.frame.origin.x = newValue }
    }
    var y: CGFloat {
        get { return self.frame.origin.y }
        set { self.frame.origin.y = newValue }
    }
    
    var width: CGFloat {
        get { return self.frame.width }
        set { self.frame.size.width = newValue }
    }
    var height: CGFloat {
        get { return self.frame.height }
        set { self.frame.size.height = newValue }
    }
    
    var size: CGSize {
        get { return self.frame.size }
        set { self.frame.size = newValue }
    }
    
    var origin: CGPoint {
        get { return self.frame.origin }
        set { self.frame.origin = newValue }
    }
    
    var left: CGFloat {
        get { return self.frame.origin.x }
        set { self.frame.origin.x = newValue }
    }
    var right: CGFloat {
        get { return self.frame.origin.x + self.frame.size.width }
        set { self.frame.origin.x = newValue - self.frame.size.width }
    }
    
    /// (视图右边距离 superView 右边的距离).
    var absRight: CGFloat {
        get {
            guard let sv = self.superview else { return self.right }
            return sv.width - self.right }
        set {
            guard let sv = self.superview else { self.right = 0; return }
            self.right = sv.width - newValue }
    }
    
    var top: CGFloat {
        get { return self.frame.origin.y }
        set { self.frame.origin.y = newValue }
    }
    var bottom: CGFloat {
        get { return self.frame.origin.y + self.frame.size.height }
        set { self.frame.origin.y = newValue - self.frame.size.height }
    }
}


extension IWViewBridge where Base: UIView {
    
    /// 切成圆形
    func round() -> Void {
        cornerRadius(base.width / 2)
    }
    
    /// 切圆角
    func cornerRadius(_ radius: CGFloat) -> Void {
        base.layer.cornerRadius = radius
        #if os(macOS)
            base.layer.masksToBounds = true
        #else
            base.clipsToBounds = true
        #endif
        base.layer.rasterizationScale = Common.Screen.scale
        base.layer.shouldRasterize = true
    }
    
    /// (将 View 转换为 UIImage).
    var screenshot: IWImage? {
        UIGraphicsBeginImageContextWithOptions(base.layer.frame.size, false, 0)
        defer {
            UIGraphicsEndImageContext()
        }
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        base.layer.render(in: context)
        return UIGraphicsGetImageFromCurrentImageContext()
    }
    /// (将 View 转换为 UIImage).
    var image: IWImage? {
        return screenshot
    }
}
