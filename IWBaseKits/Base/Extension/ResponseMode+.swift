//
//  ResponseMode+.swift
//  IWBaseKits
//
//  Created by 未来 on 2019/4/4.
//  Copyright © 2019 iWECon. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import HandyJSON
import Moya

enum TakeError: Error {
    case jsonFailed
    case responseFailed
    case modelFailed
    case modelNone
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
    
    /// 解析为 ResponseModel
    func responseModel<T>(_ cls: T.Type) -> Observable<ResponseModel<T>> where T: IWModel {
        
        return self.map({ (element) -> ResponseModel<T> in

            var dic = try! JSONSerialization.jsonObject(with: element.data, options: .mutableContainers) as? [String: Any]
            if dic.isNone {
                dic = try! JSONSerialization.jsonObject(with: RESPOND_FAILED_JSON.data(using: .utf8)!, options: .mutableContainers) as? [String: Any]
            }
            dic = try! JSONSerialization.jsonObject(with: RESPOND_FAILED_JSON.data(using: .utf8)!, options: .mutableContainers) as? [String: Any]
            let model = ResponseModel<T>.deserialize(from: dic!)
            if model.isNone {
                throw TakeError.responseFailed
            }
            if dic![safe: "data"].isSome && model!.data.isNone {
                throw TakeError.modelFailed
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

//extension Observable where Element: Moya.Response {
//
//    func responseModel() throws -> Observable<ResponseModel> {
//        return self.map({ (element) -> ResponseModel in
//
//            let dic = try? JSONSerialization.jsonObject(with: element.data, options: .mutableContainers) as? [String: Any]
//            let model = ResponseModel.deserialize(from: dic!)
//            if model.isNone {
//                throw TakeError.responseFailed
//            } else if (model.isSome.and(model!.data.isNone)) {
//                throw TakeError.modelNone
//            }
//            return model!
//        }).share(replay: 1, scope: .forever).asObservable()
//    }
//}
