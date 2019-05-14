//
//  IWView+.swift
//  IWBaseKits
//
//  Created by 未来 on 2019/4/2.
//  Copyright © 2019 iWECon. All rights reserved.
//

#if os(macOS)
    import Cocoa
#else
    import UIKit
#endif

public class IWViewBridge<Base> {
    let base: Base
    init(view: Base) {
        self.base = view
    }
}

public protocol IWViewable {
    associatedtype Base
    var iwe: Base { get }
}

public extension IWViewable {
    var iwe: IWViewBridge<Self> {
        return IWViewBridge(view: self)
    }
}

extension IWView: IWViewable { }

#if os(iOS)
fileprivate let _TAPKEY: String = "_iwe_tap"
public extension IWViewBridge where Base: IWView {
    
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
    
    func removeTap() -> Void {
        for gesture in base.gestureRecognizers! {
            if gesture is UITapGestureRecognizer, gesture.mark == _TAPKEY {
                base.removeGestureRecognizer(gesture)
            }
        }
    }
    
}
#endif
