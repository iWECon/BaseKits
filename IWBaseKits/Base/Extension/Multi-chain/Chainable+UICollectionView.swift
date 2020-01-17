//
//  Chainable+UICollectionView.swift
//  IWBaseKits
//
//  Created by 未来 on 2020/1/7.
//  Copyright © 2020 iWECon. All rights reserved.
//

import UIKit

extension Chainable where Base: UICollectionView {
    
    @discardableResult
    func collectionViewLayout(_ layout: UICollectionViewLayout) -> Chainable<Base> {
        base.collectionViewLayout = layout
        return self
    }
    @discardableResult
    func dataSource(_ ds: UICollectionViewDataSource?) -> Chainable<Base> {
        base.dataSource = ds
        return self
    }
    @discardableResult
    func delegate(_ dg: UICollectionViewDelegate?) -> Chainable<Base> {
        base.delegate = dg
        return self
    }
    @available(iOS 10.0, *)
    @discardableResult
    func prefetchDataSource(_ pds: UICollectionViewDataSourcePrefetching?) -> Chainable<Base> {
        base.prefetchDataSource = pds
        return self
    }
    @available(iOS 10.0, *)
    @discardableResult
    func enable(prefetching: Bool) -> Chainable<Base> {
        base.isPrefetchingEnabled = prefetching
        return self
    }
    @available(iOS 11.0, *)
    @discardableResult
    func dragDelegate(_ ddg: UICollectionViewDragDelegate?) -> Chainable<Base> {
        base.dragDelegate = ddg
        return self
    }
    @available(iOS 11.0, *)
    @discardableResult
    func dropDelegate(_ ddg: UICollectionViewDropDelegate?) -> Chainable<Base> {
        base.dropDelegate = ddg
        return self
    }
    @available(iOS 11.0, *)
    @discardableResult
    func enable(dragInteraction: Bool) -> Chainable<Base> {
        base.dragInteractionEnabled = dragInteraction
        return self
    }
    @available(iOS 11.0, *)
    @discardableResult
    func reorderingCadence(_ cadence: UICollectionView.ReorderingCadence) -> Chainable<Base> {
        base.reorderingCadence = cadence
        return self
    }
    @discardableResult
    func backgroundView(_ value: UIView?) -> Chainable<Base> {
        base.backgroundView = value
        return self
    }
}
