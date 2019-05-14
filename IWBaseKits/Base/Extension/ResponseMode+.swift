//
//  ResponseMode+.swift
//  IWBaseKits
//
//  Created by 未来 on 2019/4/4.
//  Copyright © 2019 iWECon. All rights reserved.
//

#if os(iOS)
import UIKit
import RxSwift
import RxCocoa
import HandyJSON
import Moya

enum TakeError: Error {
    case jsonFailed
    case responseFailed
    case modelFailed
    case dataNone
}

fileprivate let RESPOND_FAILED_JSON = """
{
"status": "failed.un-analysis",
"message": "通用数据模型解析失败",
"data": {
    "message": "错误了"
}
}
"""

extension Observable where Element: Moya.Response {
    
    func responseMediator() -> Observable<MediatorModel> {
        return self.map({ (element) -> MediatorModel in
            
            let dic = try? JSONSerialization.jsonObject(with: element.data, options: .mutableContainers) as? [String: Any]
            let model = MediatorModel.deserialize(from: dic!)
            return model!
        }).share(replay: 1, scope: .forever).asObservable()
    }
    
    /// 解析为 ResponseModel
    func responseModel<T>(_ cls: T.Type) -> Observable<ResponseModel<T>> where T: IWModel {
        
        return self.map({ (element) -> ResponseModel<T> in

            var dic = try! JSONSerialization.jsonObject(with: element.data, options: .mutableContainers) as? [String: Any]
            if dic.isNone {
                dic = try! JSONSerialization.jsonObject(with: RESPOND_FAILED_JSON.data(using: .utf8)!, options: .mutableContainers) as? [String: Any]
            }
            let model = ResponseModel<T>.deserialize(from: dic!)
            if model.isNone {
                throw TakeError.responseFailed
            }
            if dic![safe: "data"].isSome && model!.data.isNone {
                throw TakeError.modelFailed
            } else if (dic![safe: "data"].isNone) {
                throw TakeError.dataNone
            }
            Console.debug(model.any)
            return model!
        }).share(replay: 1, scope: .forever).asObservable()
    }

    /// 解析为 ResponseModels
    func responseModels<T>(_ cls: T.Type) -> Observable<ResponseModels<T>> where T: IWModel {

        return self.map({ (element) -> ResponseModels<T> in

            let dic = try? JSONSerialization.jsonObject(with: element.data, options: .mutableContainers) as? [String: Any]
            let model = ResponseModels<T>.deserialize(from: dic!)
            return model!
        }).share(replay: 1, scope: .forever).asObservable()
    }
    
}


extension Observable where Element == MediatorModel {
    
    /// Mediator.data convert to T
    func take<T>(_ cls: T.Type) -> Observable<T> {
        
        var dispose: Disposable!
        return Observable<T>.create { [weak self] (observer) -> Disposable in
            
            dispose = self?.subscribe(onNext: { (mediator) in
                
                if mediator.data.isNone {
                    observer.onError(ResponseStatus.mediatorDataNull)
                    observer.onCompleted()
                }
                
                if let t = mediator.data as? T {
                    observer.onNext(t)
                } else {
                    observer.onError(ResponseStatus.takeFailed)
                }
                observer.onCompleted()
                
            })
            
            return Disposables.create(with: {
                dispose.dispose()
            })
        }
    }
    
    /// Mediator.data convert to [T]
    func takes<T>(_ cls: T.Type) -> Observable<[T]> {
        var dispose: Disposable!
        return Observable<[T]>.create { [weak self] (observer) -> Disposable in
            
            dispose = self?.subscribe(onNext: { (mediator) in
                
                if mediator.data.isNone {
                    observer.onError(ResponseStatus.mediatorDataNull)
                    observer.onCompleted()
                }
                
                if let t = mediator.data as? [T] {
                    observer.onNext(t)
                } else {
                    observer.onError(ResponseStatus.takeFailed)
                }
                observer.onCompleted()
                
            })
            
            return Disposables.create(with: {
                dispose.dispose()
            })
        }
    }
    
}
#endif
