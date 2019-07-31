//
//  IWModel.swift
//  IWBaseKits
//
//  Created by 未来 on 2019/4/4.
//  Copyright © 2019 iWECon. All rights reserved.
//

#if (os(iOS) || os(macOS)) && canImport(HandyJSON)
import HandyJSON

public protocol IWModelProtocol: HandyJSON {
}

#if os(iOS)
public class IWModel: NSObject, IWModelProtocol {
    
    required override public init() { }
}
#endif

#if os(macOS)
public class IWModel: IWModelProtocol {
    required public init() { }
}
#endif

#endif
