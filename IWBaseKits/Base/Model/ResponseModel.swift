//
//  ResponseModel.swift
//  IWBaseKits
//
//  Created by 未来 on 2019/4/1.
//  Copyright © 2019 iWECon. All rights reserved.
//

#if (os(iOS) || os(macOS)) && canImport(HandyJSON)
import HandyJSON

public enum ResponseStatus: Swift.Error {
    case success
    case failed
    /// response.data 返回的内容是空
    case null
    /// data 转换为 json 失败
    case jsonFailed
    /// mediator 转换失败
    case mediatorFailed
    /// mediator 通用数据类型中的 data 为空
    case mediatorDataNull
    /// 将 data 中的数据转换为范型时失败
    case takeFailed
    
    var value: String {
        switch self {
        case .success:
            return "successed"
        default:
            return "failed"
        }
    }
    
    var localizedDescription: String {
        return value
    }
}

// 可自行调整键名

/// 拿到数据后生成的通用 Model
struct ResponseModel<T>: HandyJSON where T: IWModelProtocol {
    var status: String?
    var message: String?
    #if os(iOS)
    var data: T?
    #elseif os(macOS)
    var datas: T?
    #endif
}

/// 拿到数据后生成的通用 Models
struct ResponseModels<T>: HandyJSON where T: IWModelProtocol {
    var status: String?
    var message: String?
    #if os(iOS)
    var data: [T]?
    #elseif os(macOS)
    var datas: [T]?
    #endif
}

/// 生成通用数据模型，然后通过 take(model cls:) 去转换
struct MediatorModel: HandyJSON {
    var status: String?
    var message: String?
    var data: Any?
}
#endif
