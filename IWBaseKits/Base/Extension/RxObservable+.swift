//
//  RxObservable+.swift
//  IWBaseKits
//
//  Created by 未来 on 2019/3/29.
//  Copyright © 2019 iWECon. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

extension Observable {
    
    /// .subscribe(_ onNext: )
    func onNext(_ onNext: ((Element) -> Void)?) -> Disposable {
        return self.subscribe(onNext: onNext, onError: nil, onCompleted: nil, onDisposed: nil)
    }
    
}


extension SharedSequenceConvertibleType where Self.SharingStrategy == RxCocoa.DriverSharingStrategy {
    
    /// .subscribe(_ onNext: )
    func onNext(_ onNext: ((Self.E) -> Void)?) -> Disposable {
        return self.drive(onNext: onNext, onCompleted: nil, onDisposed: nil)
    }
    
}

extension ObservableType {
    
    /// .subscribe(_ onNext: )
    func onNext(_ onNext: ((Self.E) -> Void)?) -> Disposable {
        return self.subscribe(onNext: onNext, onError: nil, onCompleted: nil, onDisposed: nil)
    }
    
}
