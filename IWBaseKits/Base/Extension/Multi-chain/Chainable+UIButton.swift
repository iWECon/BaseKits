//  Created by 未来 on 2020/1/6.
//  Copyright © 2020 iWECon. All rights reserved.
//

import UIKit

extension Chainable where Base: UIControl {
    
    @discardableResult
    func enabled(_ value: Bool) -> Chainable<Base> {
        base.isEnabled = value
        return self
    }
    @discardableResult
    func selected(_ value: Bool) -> Chainable<Base> {
        base.isSelected = value
        return self
    }
    @discardableResult
    func highlighted(_ value: Bool) -> Chainable<Base> {
        base.isHighlighted = value
        return self
    }
    @discardableResult
    func contentVerticalAlignment(_ value: UIControl.ContentVerticalAlignment) -> Chainable<Base> {
        base.contentVerticalAlignment = value
        return self
    }
    @discardableResult
    func contentHorizontalAlignment(_ value: UIControl.ContentHorizontalAlignment) -> Chainable<Base> {
        base.contentHorizontalAlignment = value
        return self
    }
    @discardableResult
    func add(target: Any?, action: Selector, for controlEvents: UIControl.Event) -> Chainable<Base> {
        base.addTarget(target, action: action, for: controlEvents)
        return self
    }
    @discardableResult
    func remove(target: Any?, action: Selector?, for controlEvents: UIControl.Event) -> Chainable<Base> {
        base.removeTarget(target, action: action, for: controlEvents)
        return self
    }
    
}

extension UIControl.State: Hashable { }

extension Chainable where Base: UIButton {
    
    @discardableResult
    func contentEdge(_ insets: UIEdgeInsets) -> Chainable<Base> {
        base.contentEdgeInsets = insets
        return self
    }
    @discardableResult
    func titleEdge(_ insets: UIEdgeInsets) -> Chainable<Base> {
        base.titleEdgeInsets = insets
        return self
    }
    @discardableResult
    func imageEdge(_ insets: UIEdgeInsets) -> Chainable<Base> {
        base.imageEdgeInsets = insets
        return self
    }
    @discardableResult
    func tintColor(_ color: UIColor) -> Chainable<Base> {
        base.tintColor = color
        return self
    }
    @discardableResult
    func title(_ string: String?) -> Chainable<Base> {
        base.setTitle(string, for: .normal)
        return self
    }
    @discardableResult
    func title(_ strings: [UIControl.State: String?]) -> Chainable<Base> {
        for key in strings.keys {
            base.setTitle(strings[key] ?? "", for: key)
        }
        return self
    }
    @discardableResult
    func titleColor(_ color: UIColor) -> Chainable<Base> {
        base.setTitleColor(color, for: .normal)
        return self
    }
    @discardableResult
    func titleColor(_ colors: [UIControl.State: UIColor?]) -> Chainable<Base> {
        for (key, value) in colors {
            base.setTitleColor(value, for: key)
        }
        return self
    }
    @discardableResult
    func font(_ font: UIFont) -> Chainable<Base> {
        base.titleLabel?.font = font
        return self
    }
    @discardableResult
    func fontSize(_ fontSize: CGFloat, weight: UIFont.Weight = .regular) -> Chainable<Base> {
        base.titleLabel?.font = .systemFont(ofSize: fontSize, weight: weight)
        return self
    }
    @discardableResult
    func backgroundImage(_ image: UIImage?) -> Chainable<Base> {
        base.setBackgroundImage(image, for: .normal)
        return self
    }
    @discardableResult
    func backgroundImage(_ images: [UIControl.State: UIImage?]) -> Chainable<Base> {
        for (key, value) in images {
            base.setBackgroundImage(value, for: key)
        }
        return self
    }
    @discardableResult
    func image(_ image: UIImage?) -> Chainable<Base> {
        base.setImage(image, for: .normal)
        return self
    }
    @discardableResult
    func image(_ images: [UIControl.State: UIImage?]) -> Chainable<Base> {
        for (key, value) in images {
            base.setImage(value, for: key)
        }
        return self
    }
    @discardableResult
    func attributed(_ title: NSAttributedString?) -> Chainable<Base> {
        base.setAttributedTitle(title, for: .normal)
        return self
    }
    @discardableResult
    func attributed(_ titles: [UIControl.State: NSAttributedString?]) -> Chainable<Base> {
        for (key, value) in titles {
            base.setAttributedTitle(value, for: key)
        }
        return self
    }
}
