//
//  IWView+.swift
//  IWBaseKits
//
//  Created by 未来 on 2019/4/2.
//  Copyright © 2019 iWECon. All rights reserved.
//

import UIKit

class IWView<Base> {
    let base: Base
    init(view: Base) {
        self.base = view
    }
}

protocol IWViewable {
    associatedtype IWE
    var iwe: IWE { get }
}

extension IWViewable {
    var iwe: IWView<Self> {
        return IWView(view: self)
    }
}

extension UIView: IWViewable { }


fileprivate let _TAPKEY: String = "_iwe_tap"
extension IWView where Base: UIView {
    
    var tap: UITapGestureRecognizer {
        if base.gestureRecognizers != nil {
            for gesture in base.gestureRecognizers! {
                if gesture is UITapGestureRecognizer, gesture.mark == _TAPKEY {
                    return gesture as! UITapGestureRecognizer
                }
            }
        }
        let _tap = UITapGestureRecognizer.init()
        _tap.mark = _TAPKEY
        base.addGestureRecognizer(_tap)
        return _tap
    }
    
}
