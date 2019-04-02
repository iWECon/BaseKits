//
//  Gesture+.swift
//  IWBaseKits
//
//  Created by 未来 on 2019/4/2.
//  Copyright © 2019 iWECon. All rights reserved.
//

import UIKit

fileprivate struct _RecognizerKey {
    static var mark: Void?
}

extension UIGestureRecognizer {
    
    var mark: String? {
        get {
            if #available(iOS 11.0, *) {
                return self.name
            }
            return objc_getAssociatedObject(self, &_RecognizerKey.mark) as? String
        }
        set {
            if #available(iOS 11.0, *) {
                self.name = newValue
            } else {
                objc_setAssociatedObject(self, &_RecognizerKey.mark, newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC)
            }
        }
    }
    
}
