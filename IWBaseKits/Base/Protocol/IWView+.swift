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

extension IWView where Base: UIView {
    
    var tap: UITapGestureRecognizer {
        if base.gestureRecognizers != nil {
            for gesture in base.gestureRecognizers! {
                if gesture is UITapGestureRecognizer {
//                    if #available(iOS 11.0, *) {
//                        if gesture.name != nil, gesture.name! == "_iwe_tap" {
//                            return gesture as! UITapGestureRecognizer
//                        }
//                    } else {
//                        // Fallback on earlier versions
//                        
//                    }
                }
                
            }
        }
        let _tap = UITapGestureRecognizer.init()
//        if #available(iOS 11.0, *) {
//            _tap.name = "_iwe_tap"
//        } else {
//            // Fallback on earlier versions
//
//        }
        base.addGestureRecognizer(_tap)
        return _tap
    }
    
}
