//
//  ViewController+.swift
//  IWBaseKits
//
//  Created by 未来 on 2019/4/10.
//  Copyright © 2019 iWECon. All rights reserved.
//

#if os(iOS)
import UIKit

public extension UIViewController {
    
    /// self as! UINavigationController
    var navControl: UINavigationController {
        return self as! UINavigationController
    }
    
}
#endif
