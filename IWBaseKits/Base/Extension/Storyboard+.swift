//
//  Storyboard+.swift
//  Dove
//
//  Created by 未来 on 2019/7/10.
//  Copyright © 2019 Baige Inc. All rights reserved.
//

#if os(macOS)
    import Foundation
    import Cocoa
#elseif os(iOS)
    import UIKit
#endif


public extension IWStoryboard {
    
    // step First
    static func instance(_ name: String! = "Main", bundle: Bundle! = .main) -> IWStoryboard {
        return NSStoryboard.init(name: NSStoryboard.Name.init(name), bundle: bundle)
    }
    
    // step Second
    func instantiate(_ identifier: String) -> Any {
        return self.instantiateController(withIdentifier: NSStoryboard.SceneIdentifier.init(identifier))
    }
    
    static func initlize(_ name: String! = "Main", bundle: Bundle! = .main, identifier: String) -> Any {
        let sb = self.instance(name, bundle: .main)
        return sb.instantiate(identifier)
    }
}
