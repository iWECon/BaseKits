//
//  IWMagicApi.swift
//  IWBaseKits
//
//  Created by 未来 on 2019/4/1.
//  Copyright © 2019 iWECon. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Moya
import HandyJSON

class IWMagicApi: NSObject {
    
    let provider: IWNetworking
    
    init(provider: IWNetworking) {
        self.provider = provider
    }
}

extension IWMagicApi {
    
    func downloadString(url: URL) -> Single<String> {
        return Single.create(subscribe: { (single) -> Disposable in
            
            DispatchQueue.global().async {
                do {
                    single(.success(try String.init(contentsOf: url)))
                } catch {
                    single(.error(error))
                }
            }
            return Disposables.create { }
        }).observeOn(MainScheduler.instance)
    }
    
    func downloadFile(url: URL, fileName: String? = nil) -> Single<Void> {
        return provider.request(.download(url: url, fileName: fileName)).map({_ in }).asSingle()
    }
    
}

extension IWMagicApi: IWMagicApiPact {

    func login(account: String, password: String) -> Single<MediatorModel> {
        return requestMediator(.login(account: account, password: password))
    }

}

private extension IWMagicApi {
    
    func requestJSON(_ target: CommonAPI) -> Single<Any> {
        return provider.request(target).mapJSON().observeOn(MainScheduler.instance).asSingle()
    }
    func requestWithoutMap(_ target: CommonAPI) -> Single<Moya.Response> {
        return provider.request(target).observeOn(MainScheduler.init()).asSingle()
    }
    
    func requestMediator(_ target: CommonAPI) -> Single<MediatorModel> {
        return provider.request(target).retry(3).responseMediator().asSingle()
    }
//    func requestObject<T: IWModel>(_ target: CommonAPI, type: T.Type) -> Single<T> {
//
////        return provider.request(target).retry(3).responseModel(type.self).map({ (responseModel) -> T in
////            return responseModel.data.despair("The data(Model) is nil.")
////        }).observeOn(MainScheduler.instance).asSingle()
//
//    }
//    func requestObjects<T: IWModel>(_ target: CommonAPI, type: T.Type) -> Single<[T]> {
//        //return provider.request(target).retry(3).responseModels(type.self).map({ $0.data! }).asSingle()
//    }
    
}
