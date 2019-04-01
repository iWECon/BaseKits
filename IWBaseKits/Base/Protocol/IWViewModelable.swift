//
//  IWViewModelable.swift
//  IWBaseKits
//
//  Created by 未来 on 2019/3/29.
//  Copyright © 2019 iWECon. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

protocol IWViewModelable {
    
    var navigationBarTitle: BehaviorRelay<String> { get }
//    var navigationBarTitleDriver: Driver<String> { get }
    
    var navigationBackTitle: String? { get }
    var instanceController: IWViewControllerable { get }
    
    var backgroundColor: BehaviorRelay<UIColor> { get }
//    var backgroundColorDriver: Driver<UIColor> { get }
}
