//
//  IWProvider.swift
//  IWBaseKits
//
//  Created by 未来 on 2019/3/28.
//  Copyright © 2019 iWECon. All rights reserved.
//

import UIKit
import Moya
import RxSwift
import RxCocoa

extension Observable where Element: Equatable {
    func ignore(value: Element) -> Observable<Element> {
        return filter { (selfE) -> Bool in
            return value != selfE
        }
    }
}

class IWProvider<Target> where Target: Moya.TargetType {
    
    fileprivate let online: Observable<Bool>
    fileprivate let provider: MoyaProvider<Target>
    
    init(endpointClosure: @escaping MoyaProvider<Target>.EndpointClosure = MoyaProvider<Target>.defaultEndpointMapping,
         requestClosure: @escaping MoyaProvider<Target>.RequestClosure = MoyaProvider<Target>.defaultRequestMapping,
         stubClosure: @escaping MoyaProvider<Target>.StubClosure = MoyaProvider<Target>.neverStub,
         manager: Manager = MoyaProvider<Target>.defaultAlamofireManager(),
         plugins: [PluginType] = [],
         trackInflights: Bool = false,
         online: Observable<Bool> = IWReachability.connected) {
        
        self.online = online
        self.provider = MoyaProvider(endpointClosure: endpointClosure,
                                     requestClosure: requestClosure,
                                     stubClosure: stubClosure,
                                     manager: manager,
                                     plugins: plugins,
                                     trackInflights: trackInflights)
    }
    
    func request(_ token: Target) -> Observable<Moya.Response> {
        let actualRequest = provider.rx.request(token)
        
        return online.ignore(value: false).take(1).flatMap { _ in
            return actualRequest.filterSuccessfulStatusCodes().do(onError: { (error) in
                if let error = error as? MoyaError {
                    switch error {
                    case .statusCode(let response):
                        if response.statusCode == 401 {
                            // ...
                        }
                    default:
                        break
                    }
                }
            })
        }
    }
}


protocol IWNetworkingType {
    associatedtype T: TargetType
    var provider: IWProvider<T> { get }
}

struct IWNetworking: IWNetworkingType {
    typealias T = CommonAPI
    let provider: IWProvider<CommonAPI>
}

extension IWNetworkingType {
    
    static func networking() -> IWNetworking {
        return IWNetworking.init(provider: IWProvider<CommonAPI>.init())
    }
    
}

extension IWNetworking {
    
    func request(_ token: CommonAPI) -> Observable<Moya.Response> {
        let request = self.provider.request(token)
        return request
    }
    
    
    
}


extension IWNetworkingType {
    
    static func endpointsClosure<T>(_ xAccessToken: String? = nil) -> (T) -> Endpoint where T: TargetType {
        return { target in
            let endpoint = MoyaProvider.defaultEndpointMapping(for: target)
            
            // Sign all non-XApp, non-XAuth token requests
            return endpoint
        }
    }
    
    static func endpointResolver() -> MoyaProvider<T>.RequestClosure {
        return { (endpoint, closure) in
            do {
                var request = try endpoint.urlRequest() // endpoint.urlRequest
                request.httpShouldHandleCookies = false
                closure(.success(request))
            } catch {
                Console.error(error.localizedDescription)
            }
        }
    }
}
