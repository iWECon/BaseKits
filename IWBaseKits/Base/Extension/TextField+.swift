//
//  TextField+.swift
//  IWBaseKits
//
//  Created by 未来 on 2019/4/3.
//  Copyright © 2019 iWECon. All rights reserved.
//

#if os(iOS)

import UIKit

public extension UITextField {
    
    /// (placeholder 文字颜色).
    var placeholderColor: UIColor {
        get { return value(forKeyPath: "_placeholderLabel.textColor") as! UIColor }
        set { setValue(newValue, forKeyPath: "_placeholderLabel.textColor") }
    }
    
    /// (placeholder 字体大小).
    var placeholderFontSize: Float {
        get { return (value(forKeyPath: "_placeholderLabel.font") as! CGFloat).float }
        set { setValue(UIFont.systemFont(ofSize: newValue.cgFloat), forKeyPath: "_placeholderLabel.font") }
    }
    
    /// (numberOfLines).
    var placeholderLine: Int {
        get { return (value(forKeyPath: "_placeholderLabel.numberOfLines") as! Int) }
        set { setValue(newValue, forKeyPath: "_placeholderLabel.numberOfLines") }
    }
    
    /// (左 内边距, 若需要自定义 leftView 请勿使用).
    func left(padding: CGFloat) {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: padding, height: 1))
        view.backgroundColor = .clear
        leftView = view
        leftViewMode = .always
    }
    /// (右 内边距, 若需要自定义 rightView 请勿使用).
    func right(padding: CGFloat) {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: padding, height: 1))
        view.backgroundColor = .clear
        rightView = view
        rightViewMode = .always
    }
    
}

#endif
