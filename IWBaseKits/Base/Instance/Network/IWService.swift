//
//  IWService.swift
//  IWBaseKits
//
//  Created by 未来 on 2019/3/26.
//  Copyright © 2019 iWECon. All rights reserved.
//

/**
 * USE GUIDE
 1. 需要先初始化服务器配置, 参见 AppDelegate.swift -> initForProvider()
 2. 需要配置相关的接口信息, 参见 CommonAPI.swift
 */

#if (os(iOS) || os(macOS)) && canImport(Moya) && canImport(RxSwift) && canImport(RxCocoa) && canImport(NSObject_Rx)
import Moya
import RxSwift
import RxCocoa
import NSObject_Rx

public class IWService: NSObject {
    
    public static let shared: IWService = IWService.init()
    
    /// The mode of request host
    public enum Mode {
        /// DEBUG
        case debug
        /// RELEASE
        case release
        
        var value: String {
            switch self {
            case .debug:
                return "debug"
            default:
                return "release"
            }
        }
    }
    
    /// The service Model of RELEASE
    private var releaseServiceModel_: IWServiceModel!
    /// The service Model of DEBUG
    private var debugServiceModel_: IWServiceModel?
    
    /// The service Model of current using
    private var serviceModel_: IWServiceModel!
    /// The service mode
    private var mode_: BehaviorRelay<Mode>!
    
    /// The service mode
    public var mode: Mode {
        return self.mode_.value
    }
    
    public var validateURL: URL {
        return serviceModel_.validatedURL
    }
    public var headers: [String: String]? {
        return serviceModel_.headers
    }
    
    private override init() { }
    
    /// The Mode's default is .release.
    convenience init(release: IWServiceModel!, debug: IWServiceModel?, mode: Mode = .release) {
        self.init()
        
        bind(release: release, debug: debug, mode: mode)
    }
    
    public func bind(release: IWServiceModel!, debug: IWServiceModel?, mode: Mode = .release) -> Void {
        self.releaseServiceModel_ = release
        self.debugServiceModel_ = debug
        self.mode_ = BehaviorRelay<Mode>.init(value: mode)
        self.serviceModel_ = (mode == .release) ? release : ((debug == nil) ? release : debug)
        print("The Provider's mode is initialized with \(mode.value)!")
        
        initlized()
    }
    
    /// Switch Service Mode
    public func switchMode() -> Void {
        if mode == .debug {
            mode_.accept(.release)
            
        } else {
            
            if self.debugServiceModel_ == nil {
                print("The Provider's mode is still running with \(self.mode.value). Bcz the Provider's debugServiceModel is nil, so u only have one choice (.release). This means u can't change the mode!")
                return
            }
            
            mode_.accept(.release)
        }
    }
    
}

private extension IWService {
    
    func initlized() -> Void {
        
        mode_.asDriver().skip(1).distinctUntilChanged().asObservable().subscribe(onNext: { [weak self] (value) in
            
            guard let self = self else { return }
            
            if value == .debug {
                self.serviceModel_ = self.debugServiceModel_
                print("The Provider's mode is running with debug!")
            } else {
                print("The Provider's mode is running with release!")
                self.serviceModel_ = self.releaseServiceModel_
            }
            
        }).disposed(by: rx.disposeBag)
    }
    
}
#endif
