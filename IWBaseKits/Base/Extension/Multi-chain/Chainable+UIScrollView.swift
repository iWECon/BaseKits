//
//  Chainable+UIScrollView.swift
//  IWBaseKits
//
//  Created by 未来 on 2020/1/7.
//  Copyright © 2020 iWECon. All rights reserved.
//

import UIKit

extension Chainable where Base: UIScrollView {
    
    @discardableResult
    func contentOffset(_ offset: CGPoint) -> Chainable<Base> {
        base.contentOffset = offset
        return self
    }
    @discardableResult
    func contentSize(_ size: CGSize) -> Chainable<Base> {
        base.contentSize = size
        return self
    }
    @discardableResult
    func contentInset(_ inset: UIEdgeInsets) -> Chainable<Base> {
        base.contentInset = inset
        return self
    }
    @available(iOS 11.0, *)
    @discardableResult
    func contentInset(adjustment behavior: UIScrollView.ContentInsetAdjustmentBehavior) -> Chainable<Base> {
        base.contentInsetAdjustmentBehavior = behavior
        return self
    }
    @available(iOS 13.0, *)
    @discardableResult
    func automaticallyAdjustsScrollIndicatorInsets(_ value: Bool) -> Chainable<Base> {
        base.automaticallyAdjustsScrollIndicatorInsets = value
        return self
    }
    @discardableResult
    func delegate(_ value: UIScrollViewDelegate?) -> Chainable<Base> {
        base.delegate = value
        return self
    }
    @discardableResult
    func enable(directional lock: Bool) -> Chainable<Base> {
        base.isDirectionalLockEnabled = lock
        return self
    }
    @discardableResult
    func bounces(_ value: Bool) -> Chainable<Base> {
        base.bounces = value
        return self
    }
    @discardableResult
    func bounce(vertical always: Bool) -> Chainable<Base> {
        base.alwaysBounceVertical = always
        return self
    }
    @discardableResult
    func bounce(horizontal always: Bool) -> Chainable<Base> {
        base.alwaysBounceHorizontal = always
        return self
    }
    @discardableResult
    func enable(paging: Bool) -> Chainable<Base> {
        base.isPagingEnabled = paging
        return self
    }
    @discardableResult
    func enable(scroll: Bool) -> Chainable<Base> {
        base.isScrollEnabled = scroll
        return self
    }
    @discardableResult
    func show(verticalScrollIndicator: Bool) -> Chainable<Base> {
        base.showsVerticalScrollIndicator = verticalScrollIndicator
        return self
    }
    @discardableResult
    func show(horizontalScrollIndicator: Bool) -> Chainable<Base> {
        base.showsHorizontalScrollIndicator = horizontalScrollIndicator
        return self
    }
    @discardableResult
    func style(indicator style: UIScrollView.IndicatorStyle) -> Chainable<Base> {
        base.indicatorStyle = style
        return self
    }
    @available(iOS 11.1, *)
    @discardableResult
    func indicator(vertical insets: UIEdgeInsets) -> Chainable<Base> {
        base.verticalScrollIndicatorInsets = insets
        return self
    }
    @available(iOS 11.1, *)
    @discardableResult
    func indicator(horizontal insets: UIEdgeInsets) -> Chainable<Base> {
        base.horizontalScrollIndicatorInsets = insets
        return self
    }
    @discardableResult
    func indicaotr(scroll insets: UIEdgeInsets) -> Chainable<Base> {
        base.scrollIndicatorInsets = insets
        return self
    }
    @discardableResult
    func contentTouches(delay: Bool) -> Chainable<Base> {
        base.delaysContentTouches = delay
        return self
    }
    @discardableResult
    func contentTouches(canCancel: Bool) -> Chainable<Base> {
        base.canCancelContentTouches = canCancel
        return self
    }
    @discardableResult
    func zoomScale(minimum: CGFloat) -> Chainable<Base> {
        base.minimumZoomScale = minimum
        return self
    }
    @discardableResult
    func zoomScale(maximum: CGFloat) -> Chainable<Base> {
        base.maximumZoomScale = maximum
        return self
    }
    @discardableResult
    func zoomScale(_ value: CGFloat) -> Chainable<Base> {
        base.zoomScale = value
        return self
    }
    @discardableResult
    func bouncesZoom(_ value: Bool) -> Chainable<Base> {
        base.bouncesZoom = value
        return self
    }
    @discardableResult
    func keyboardDismiss(mode: UIScrollView.KeyboardDismissMode) -> Chainable<Base> {
        base.keyboardDismissMode = mode
        return self
    }
    @available(iOS 10.0, *)
    @discardableResult
    func refreshControl(_ control: UIRefreshControl?) -> Chainable<Base> {
        base.refreshControl = control
        return self
    }
}
