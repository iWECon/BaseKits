//
//  IWMagicApiPact.swift
//  IWBaseKits
//
//  Created by 未来 on 2019/4/1.
//  Copyright © 2019 iWECon. All rights reserved.
//

#if os(iOS)
import UIKit
import RxSwift
import RxCocoa

protocol IWMagicApiPact {
    
    func login(account: String, password: String) -> Single<MediatorModel>
    
}
#endif
