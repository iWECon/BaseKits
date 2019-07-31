//
//  CommonAPI.swift
//  IWBaseKits
//
//  Created by 未来 on 2019/3/26.
//  Copyright © 2019 iWECon. All rights reserved.
//

#if os(iOS) && canImport(Moya) && canImport(RxSwift) && canImport(RxCocoa)
import Moya
import RxSwift
import RxCocoa

public enum CommonAPI {
    case none
    case login(account: String, password: String)
    case download(url: URL, fileName: String?)
    case userProfile
}

extension CommonAPI: TargetType {
    
    public func request() -> Observable<Moya.Response> {
        return AppDelegate.shared.provider.request(self).asObservable()
    }
    
    /// 需要做对应的接口路径处理
    public var path: String {
        switch self {
        case .login(account: _, password: _):
            return "/Index/loginDo"
        case .userProfile:
            return "/Newapi/get_shop_info"
        default:
            return ""
        }
    }
    
    /// 需要做对应的接口请求方式处理
    public var method: Moya.Method {
        switch self {
        default:
            return .post
        }
    }
    
    public var params: [String: Any]? {
        var _params: [String: Any] = [:]
        switch self {
        case .login(account: let act, password: let psd):
            _params["user_name"] = act
            _params["passwd"] = psd
        case .userProfile:
            _params["shop_id"] = "7"
        default:
            break
        }
        return _params
    }
    
    
    
    /// 这里表示只返回 2xx 的回调信息, 默认值为 .none
    public var validationType: ValidationType {
        return .successCodes // 这里的意思是只返回 2xx 的回调
    }
    
    /// 头, 根据接口情况进行配置
    public var headers: [String: String]? {
        let _headers = IWService.shared.headers
        switch self {
        case .none:
            // U can do add or remove. Remember change the _headers's `let` to `var`
            // _headers?["xixix"] = "123"
            break
        default:
            break
        }
        return _headers
    }
    
    
    // MARK:- 一般情况下无需进行修改
    /// 一般无需操作
    public var task: Task {
        switch self {
        case .none:
            return .requestPlain
        default:
            if let parameters = params {
                return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
            }
            return .requestPlain
        }
    }
    /// 无需修改
    public var baseURL: URL {
        return IWService.shared.validateURL
    }
    /// 用于测试的数据, 可以创建 .json 文件
    public var sampleData: Data {
        switch self {
        default:
            break
        }
        return Data()
    }
}
#endif
