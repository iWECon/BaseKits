//
//  Typealias.swift
//  Dove
//
//  Created by 未来 on 2019/5/11.
//  Copyright © 2019 Baige Inc. All rights reserved.
//

#if os(macOS)
    import Cocoa
    public typealias IWView = NSView
    public typealias IWSize = NSSize
    public typealias IWColor = NSColor
    public typealias IWImage = NSImage
    public typealias IWRect = NSRect
    public typealias IWPoint = NSPoint
    public typealias IWImageView = NSImageView
    public typealias IWEdgeInsets = NSEdgeInsets
    public typealias IWStoryboard = NSStoryboard
#else
    import UIKit
    public typealias IWView = UIView
    public typealias IWSize = CGSize
    public typealias IWColor = UIColor
    public typealias IWImage = UIImage
    public typealias IWRect = CGRect
    public typealias IWPoint = CGPoint
    public typealias IWImageView = UIImageView
    public typealias IWEdgeInsets = UIEdgeInsets
    public typealias IWStoryboard = UIStoryboard
#endif
