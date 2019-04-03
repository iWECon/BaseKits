//
//  Label+.swift
//  IWBaseKits
//
//  Created by 未来 on 2019/4/3.
//  Copyright © 2019 iWECon. All rights reserved.
//

import UIKit

public extension UILabel {
    
    convenience init(text: String) {
        self.init()
        self.text = text
    }
    
    /// Copy style(font, textColor, lineBreakMode, textAlignment, backgroundColor) for label to self.
    func same(as label: UILabel) -> Void {
        self.font = label.font
        self.textColor = label.textColor
        self.lineBreakMode = label.lineBreakMode
        self.textAlignment = label.textAlignment
        self.backgroundColor = label.backgroundColor
    }
}
