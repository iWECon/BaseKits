//
//  RectCorner+.swift
//  IWBaseKits
//
//  Created by 未来 on 2019/4/3.
//  Copyright © 2019 iWECon. All rights reserved.
//

#if os(iOS) || os(tvOS)

import UIKit

public extension UIRectCorner {
    
    /// (topLeft, topRight).
    static var top: UIRectCorner {
        return [.topLeft, .topRight]
    }
    /// (topLeft, bottomLeft).
    static var left: UIRectCorner {
        return [.topLeft, .bottomLeft]
    }
    /// (topRight, bottomRight).
    static var right: UIRectCorner {
        return [.topRight, .bottomRight]
    }
    /// (bottomLeft, bottomRight).
    static var bottom: UIRectCorner {
        return [.bottomLeft, .bottomRight]
    }
    
}

#endif
