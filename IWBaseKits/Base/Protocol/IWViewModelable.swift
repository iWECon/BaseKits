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
    
    var autoAddBackBarButton: Bool { get set }
    
    func destroy(_ animated: Bool) -> Void
    
    /// execution error callback, if request error happend
    func requestError(_ status: ResponseStatus) -> Void
    /// execution error retry callback, if request error happend
    func requestRetry(_ status: ResponseStatus) -> Void
    
    var dataSources: BehaviorRelay<Any> { get }
}
