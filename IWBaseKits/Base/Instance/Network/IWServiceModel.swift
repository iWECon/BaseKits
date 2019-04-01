//
//  IWServiceModel.swift
//  IWBaseKits
//
//  Created by 未来 on 2019/3/26.
//  Copyright © 2019 iWECon. All rights reserved.
//

import UIKit
import Moya

public class IWServiceModel: NSObject {
    
    enum Scheme {
        case http
        case https
        case ftp
        
        var value: String {
            switch self {
            case .http:
                return "http"
            case .https:
                return "https"
            case .ftp:
                return "ftp"
            }
        }
    }
    
    var scheme: Scheme!
    var host: String!
    var path: String!
    var headers: [String: String]?
    
    private override init() { }
    
    /// 初始化
    ///
    /// - Parameters:
    ///   - scheme: Scheme
    ///   - host: Host
    ///   - path: Path, need prefix is /
    ///   - headers: Default is nil
    convenience init(scheme: Scheme, host: String, path: String, headers: [String: String]? = nil) {
        self.init()
        
        self.scheme = scheme
        self.host = host
        self.path = path
        self.headers = headers
    }
    
    lazy var validatedURL: URL = {
        let concatedString = scheme.value + "://" + host + path
        guard let validatedURL = URL.init(string: concatedString) else {
            fatalError("The string(\(concatedString)) can't convert to URL!")
        }
        return validatedURL
    }()
    
}
