//  Created by 未来 on 2020/1/5.
//  Copyright © 2020 iWECon. All rights reserved.
//

import UIKit

extension UIView: Chain { }
extension Chainable where Base: UIView {
   
    @discardableResult
    func background(_ color: UIColor) -> Chainable<Base> {
        base.backgroundColor = color
        return self
    }
    @discardableResult
    func tag(_ value: Int) -> Chainable<Base> {
        base.tag = value
        return self
    }
    @discardableResult
    func enable(userInteraction value: Bool) -> Chainable<Base> {
        base.isUserInteractionEnabled = value
        return self
    }
    @discardableResult
    func alpha(_ value: CGFloat) -> Chainable<Base> {
        base.alpha = value
        return self
    }
    @discardableResult
    func isHidden(_ value: Bool) -> Chainable<Base> {
        base.isHidden = value
        return self
    }
    @discardableResult
    func contentMode(_ value: UIView.ContentMode) -> Chainable<Base> {
        base.contentMode = value
        return self
    }
    @discardableResult
    func clips(_ value: Bool) -> Chainable<Base> {
        base.clipsToBounds = value
        return self
    }
    @discardableResult
    func frame(_ value: CGRect) -> Chainable<Base> {
        base.frame = value
        return self
    }
    @discardableResult
    func bounds(_ value: CGRect) -> Chainable<Base> {
        base.bounds = value
        return self
    }
    @discardableResult
    func transform(_ value: CGAffineTransform) -> Chainable<Base> {
        base.transform = value
        return self
    }
    @discardableResult
    func addSubview(_ subview: UIView...) -> Chainable<Base> {
        for v in subview {
            base.addSubview(v)
        }
        return self
    }
    @discardableResult
    func add(to: UIView) -> Chainable<Base> {
        to.addSubview(base)
        return self
    }
}
