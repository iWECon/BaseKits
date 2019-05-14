//
//  ImageView+.swift
//  Dove
//
//  Created by 未来 on 2019/5/11.
//  Copyright © 2019 Baige Inc. All rights reserved.
//

#if os(macOS)
import Cocoa

public extension IWImageView {
    
    
    /// Set cornerRadius for layer, auto enable wantsLayer if it is false
    var cornerRadius: CGFloat {
        get {
            if !self.wantsLayer {
                // fatalError("The layer is nil")
                self.wantsLayer = true
            }
            return self.layer!.cornerRadius
        }
        set {
            if !self.wantsLayer {
                // fatalError("The layer is nil")
                self.wantsLayer = true
            }
            self.layer!.cornerRadius = newValue
        }
    }
    
}

#endif
