//
//  String+.swift
//  IWBaseKits
//
//  Created by 未来 on 2019/3/30.
//  Copyright © 2019 iWECon. All rights reserved.
//

import UIKit

//extension String {
//
//    func check(_ process: (String) -> Bool) -> Bool {
//        return process(self ?? "")
//    }
//
//}


extension Optional where Wrapped == String {
    
    func check(_ process: (String) -> Bool) -> Bool {
        return process(self ?? "")
    }
    
}
