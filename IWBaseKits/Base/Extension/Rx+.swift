//
//  Rx+.swift
//  IWBaseKits
//
//  Created by 未来 on 2019/3/29.
//  Copyright © 2019 iWECon. All rights reserved.
//

#if os(iOS) || os(macOS)

#if canImport(RxSwift) && canImport(RxCocoa)
import RxSwift
import RxCocoa

extension Observable {
    
    /// .subscribe(_ onNext: )
    func onNext(_ onNext: ((Element) -> Void)?) -> Disposable {
        return self.subscribe(onNext: onNext, onError: nil, onCompleted: nil, onDisposed: nil)
    }
    
    func doNext(_ doNext: ((Element) throws -> Void)?) -> Observable<Element> {
        return self.do(onNext: doNext)
    }
    
    func mapReplace<T>(_ value: T) -> Observable<T> {
        return self.map({ (_) -> T in
            return value
        })
    }
}

extension SharedSequenceConvertibleType where Self.SharingStrategy == RxCocoa.DriverSharingStrategy {
    /// .drive(_ onNext: )
    func onNext(_ onNext: ((Self.Element) -> Void)?) -> Disposable {
        return self.drive(onNext: onNext, onCompleted: nil, onDisposed: nil)
    }
}

extension ObservableType {
    /// .subscribe(_ onNext: )
    func onNext(_ onNext: ((Self.Element) -> Void)?) -> Disposable {
        return self.subscribe(onNext: onNext, onError: nil, onCompleted: nil, onDisposed: nil)
    }
    
    /// 空函数
    func mapToVoid() -> Observable<Void> {
        return map { _ in }
    }
}

extension Observable where Element: Any {
    var mapDictionary: Observable<[String: Any]> {
        return self.map({ (object) -> [String: Any] in
            return object as! [String: Any]
        })
    }
}

#endif

#if os(iOS)
import KafkaRefresh
extension IWViewBridge where Base: UIView {
    
    var rx: Reactive<Base> {
        return base.rx
    }
    
}
extension Reactive where Base: UIView {
    
    var tap: ControlEvent<UITapGestureRecognizer> {
        return base.iwe.tap.rx.event
    }
    
    var frame: Observable<CGRect?> {
        return base.rx.observe(CGRect.self, "frame")
    }
}


extension Reactive where Base: UIButton {
    
    var touchUpInside: Driver<()> {
        return base.rx.controlEvent(.touchUpInside).asDriver()
    }
    
    var touchUpOutside: Driver<()> {
        return base.rx.controlEvent(.touchUpOutside).asDriver()
    }
    
}


extension Reactive where Base: KafkaRefreshControl {
    var isAnimating: Binder<Bool> {
        return Binder.init(self.base, binding: { (refreshControler, active) in
            if active {
//                refreshControler.beginRefreshing()
            } else {
                refreshControler.endRefreshing()
            }
        })
    }
}
#endif
#endif
