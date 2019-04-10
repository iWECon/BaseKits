//
//  LanguageController.swift
//  IWBaseKits
//
//  Created by 未来 on 2019/4/9.
//  Copyright © 2019 iWECon. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

class LanguageController: IWTableViewController {
    
    var vm: LanguageViewModel {
        return viewModel as! LanguageViewModel
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func prepareUI() {
        super.prepareUI()
    
        navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "完成", style: .plain, target: nil, action: nil)
        
        tableView.registReusable(UITableViewCell.self)
        tableView.headRefreshControl = nil
        tableView.footRefreshControl = nil
        tableView.tableHeaderView = UIView(height: .min)
    }
    
    override func bindViewModel() {
        super.bindViewModel()

        let input = LanguageViewModel.Input.init(selectModelTrigger: tableView.rx.modelSelected(LanguageSectionItem.self).asDriver(),
                                                 itemSelectedTrigger: tableView.rx.itemSelected.asDriver(),
                                                 doneTrigger: navigationItem.rightBarButtonItem!.rx.tap.asDriver())

        let output = vm.transform(input)
        tableView.registReusable(UITableViewCell.self)

        let dataSources = RxTableViewSectionedReloadDataSource<LanguageSection>.init(configureCell: ({ (ds, tv, idx, item) -> UITableViewCell in
            switch item {
            case .languageItem(let cvm):
                let cell = tv.reuseCell() as UITableViewCell
                cell.textLabel?.text = cvm.name
                return cell
            }
        }), titleForHeaderInSection: { (ds, section) -> String? in
            return ds.sectionModels[section].title
        })

        output.items.asObservable().bind(to: tableView.rx.items(dataSource: dataSources)).disposed(by: rx.disposeBag)
        output.isDone.asObservable().bind(to: navigationItem.rightBarButtonItem!.rx.isEnabled).disposed(by: rx.disposeBag)
    }

}
