//
//  IWViewControllerable.swift
//  IWBaseKits
//
//  Created by 未来 on 2019/3/29.
//  Copyright © 2019 iWECon. All rights reserved.
//

#if os(iOS)
import UIKit

protocol IWViewControllerable {
    
    /// Attach viewModel to ViewController
    ///
    /// - Parameter viewModel: ViewModel
    /// - Returns: Void
    func attach(viewModel: Any) -> Void
    
    static var `class`: String { get }
}

extension IWViewControllerable {
    
    static var `class`: String {
        return "\(self)"
    }
    
    /// self as! UIViewController
//    var controller: UIViewController {
//        return self as! UIViewController
//    }
}
#endif
