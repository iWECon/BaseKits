//
//  ResponseModel.swift
//  IWBaseKits
//
//  Created by 未来 on 2019/4/1.
//  Copyright © 2019 iWECon. All rights reserved.
//

import UIKit

/// 拿到数据后生成的通用 Model
class ResponseModel: NSObject, Codable {
    
    var status: String?
    var message: String?
    var data: String?
    
}
