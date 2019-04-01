//
//  IWViewControllerable.swift
//  IWBaseKits
//
//  Created by 未来 on 2019/3/29.
//  Copyright © 2019 iWECon. All rights reserved.
//

import UIKit

protocol IWViewControllerable {
    
    /// Attach viewModel to ViewController
    ///
    /// - Parameter viewModel: ViewModel
    /// - Returns: Void
    func attach(viewModel: Any) -> Void
    
}
