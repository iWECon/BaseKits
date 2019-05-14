//
//  IWTableViewController.swift
//  IWBaseKits
//
//  Created by 未来 on 2019/4/8.
//  Copyright © 2019 iWECon. All rights reserved.
//

#if os(iOS)
import UIKit
import RxSwift
import RxCocoa
import KafkaRefresh

class IWTableViewController: IWViewController {
    
    private var _tableViewStyle: UITableView.Style = .grouped
    public var tableView: IWTableView!
    
    let headerRefreshTrigger = PublishSubject<Void>()
    let footerLoadMoreTrigger = PublishSubject<Void>()

    let isHeaderRefreshing = BehaviorRelay.init(value: false)
    let isFooterLoading = BehaviorRelay.init(value: false)
    
    /// Deprecated, use `init(viewModel:, style:)`
    /// The default tableViewStyle is grouped.
    convenience init(viewModel: IWViewModelable) {
        self.init(nibName: nil, bundle: nil)
        
        self.viewModel = viewModel
        _tableViewStyle = .grouped
    }
    
    convenience init(viewModel: IWViewModelable, style: UITableView.Style) {
        self.init(nibName: nil, bundle: nil)
        
        self.viewModel = viewModel
        _tableViewStyle = style
    }
    
    override func prepareUI() {
        super.prepareUI()
        
        let tbv = IWTableView.init(frame: ScreenBounds, style: _tableViewStyle)
        tbv.rx.setDelegate(self).disposed(by: rx.disposeBag)
        view.addSubview(tbv)
        tableView = tbv
        
        tableView.bindGlobalStyle(forFootRefreshHandler: { [weak self] in
            self?.headerRefreshTrigger.onNext(())
        })
        tableView.bindGlobalStyle(forFootRefreshHandler: { [weak self] in
            self?.footerLoadMoreTrigger.onNext(())
        })

        // isHeaderRefreshing.bind(to: tableView.headRefreshControl.rx.isAnimating).disposed(by: rx.disposeBag)
        // isFooterLoading.bind(to: tableView.footRefreshControl.rx.isAnimating).disposed(by: rx.disposeBag)

        /// Auto refresh on foot 滑动到底部后自动加载更多
        tableView.footRefreshControl.autoRefreshOnFoot = false
    }
    
}


extension IWTableViewController: UITableViewDelegate {
    
    
}
#endif
