//
//  IWReachability.swift
//  IWBaseKits
//
//  Created by 未来 on 2019/3/28.
//  Copyright © 2019 iWECon. All rights reserved.
//

#if os(iOS)
import UIKit
import RxSwift
import Reachability

public struct IWReachability {
    
    static var connected: Observable<Bool> {
        return _IWReachability.shared.reach
    }
    
    private init() { }
    
}

private class _IWReachability: NSObject {
    
    static let shared = _IWReachability()
    
    fileprivate let reachability = Reachability.init()
    
    let _reach = ReplaySubject<Bool>.create(bufferSize: 1)
    var reach: Observable<Bool> {
        return _reach.asObservable()
    }
    
    override init() {
        super.init()
        
        reachability?.whenReachable = { reachability in
            DispatchQueue.main.async {
                self._reach.onNext(true)
            }
        }
        
        reachability?.whenUnreachable = { reachability in
            DispatchQueue.main.async {
                self._reach.onNext(false)
            }
        }
        
        do {
            try reachability?.startNotifier()
            _reach.onNext(reachability?.connection != .none)
        } catch {
            print("Unable to start notifier")
        }
    }

}
#endif
