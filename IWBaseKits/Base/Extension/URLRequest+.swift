//
//  URLRequest+.swift
//  IWBaseKits
//
//  Created by 未来 on 2019/4/3.
//  Copyright © 2019 iWECon. All rights reserved.
//

#if os(macOS)
    import Cocoa
#else
    import UIKit
#endif


public extension URLRequest {
    
    init?(urlString: String) {
        guard let url = urlString.url else { return nil }
        self.init(url: url)
    }
    
}
