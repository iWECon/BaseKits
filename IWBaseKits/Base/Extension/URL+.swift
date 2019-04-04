//
//  URL+.swift
//  IWBaseKits
//
//  Created by 未来 on 2019/4/3.
//  Copyright © 2019 iWECon. All rights reserved.
//

import UIKit

public extension URL {
    
    var params: [String: String]? {
        guard let components = URLComponents(url: self, resolvingAgainstBaseURL: false), let queryItems = components.queryItems else { return nil }
        
        var items: [String: String] = [:]
        for queryItem in queryItems {
            items[queryItem.name] = queryItem.value
        }
        return items
    }
    
}


public extension URL {
    
    /// (添加参数到链接后).
    ///
    ///     let url = URL(string: "https://www.google.com")!
    ///     let param = ["q": "IWExtension"]
    ///     url.appendingQueryParameters(param) -> "https://google.com?q=Swifter%20Swift"
    func append(params parameters: [String: String]) -> URL {
        var urlComponents = URLComponents(url: self, resolvingAgainstBaseURL: true)!
        var items = urlComponents.queryItems ?? []
        items += parameters.map({ URLQueryItem(name: $0, value: $1) })
        urlComponents.queryItems = items
        return urlComponents.url!
    }
    
}
