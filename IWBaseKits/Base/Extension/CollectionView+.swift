//
//  CollectionView+.swift
//  IWBaseKits
//
//  Created by 未来 on 2019/4/3.
//  Copyright © 2019 iWECon. All rights reserved.
//

#if os(iOS)
import UIKit

extension IWViewBridge where Base: UICollectionView {
    
    /// (最后一个 secion).
    var lastSection: Int {
        return base.numberOfSections > 0 ? base.numberOfSections - 1 : 0
    }
    /// (最后一个 item 的 indexPath).
    var indexPathForLastItem: IndexPath? {
        return indexPathForLastItem(inSection: lastSection)
    }
    
    /// (section 中最后的 item 的 indexPath)
    func indexPathForLastItem(inSection section: Int) -> IndexPath? {
        guard section >= 0 else {
            return nil
        }
        guard section < base.numberOfSections else {
            return nil
        }
        guard base.numberOfItems(inSection: section) > 0 else {
            return IndexPath(item: 0, section: section)
        }
        return IndexPath(item: base.numberOfItems(inSection: section) - 1, section: section)
    }
    
}
#endif
