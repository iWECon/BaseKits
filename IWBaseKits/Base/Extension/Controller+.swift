//
//  Controller+.swift
//  IWBaseKits
//
//  Created by 未来 on 2019/3/30.
//  Copyright © 2019 iWECon. All rights reserved.
//

import UIKit

//extension UIViewController {
//
////    static func initFromStoryBoard(_ name: "") ->
//
//}

extension IWViewControllerable where Self: UIViewController {
    
    static func from(storyboard name: String = "Main") -> Self {
        let sb = UIStoryboard.init(name: name, bundle: Bundle.main)
        return sb.instantiateViewController(withIdentifier: "\(Self.self)") as! Self
    }
    
}
