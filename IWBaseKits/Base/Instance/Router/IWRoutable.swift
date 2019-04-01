//
//  IWRoutable.swift
//  IWBaseKits
//
//  Created by 未来 on 2019/3/28.
//  Copyright © 2019 iWECon. All rights reserved.
//

import UIKit


public protocol IWRouterable {
    
    static var controller: UIViewController { get }
//    static func push(with params: IWRouterParams?) -> Void
//    static func presenter(with params: IWRouterParams?) -> Void
    
}
