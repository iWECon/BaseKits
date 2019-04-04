//
//  ResponseModel.swift
//  IWBaseKits
//
//  Created by 未来 on 2019/4/1.
//  Copyright © 2019 iWECon. All rights reserved.
//

#if os(macOS)
    import Cocoa
#else
    import UIKit
#endif

import HandyJSON

//protocol IWResponseModelable {
//    var status: String? { get }
//    var message: String?{ get }
//    var data: IWModel?  { get }
//}
//
//protocol IWResponseModelsable {
//    var status: String? { get }
//    var message: String?{ get }
//    var data: [IWModel]?  { get }
//}

enum ResponseStatus {
    case success
    case failed
    
    var value: String {
        switch self {
        case .success:
            return "successed"
        default:
            return "failed"
        }
    }
}

// 可自行调整键名

/// 拿到数据后生成的通用 Model
struct ResponseModel<T>: HandyJSON where T: IWModel {
    var status: String?
    var message: String?
    var data: T?
}

/// 拿到数据后生成的通用 Models
struct ResponseModels<T>: HandyJSON where T: IWModel {
    var status: String?
    var message: String?
    var data: [T]?
}
