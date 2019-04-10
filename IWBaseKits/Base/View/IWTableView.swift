//
//  IWTableView.swift
//  IWBaseKits
//
//  Created by 未来 on 2019/4/8.
//  Copyright © 2019 iWECon. All rights reserved.
//

import UIKit
import Then

class IWTableView: UITableView {
    
    deinit {
        Console.debug("The <\(type(of: self))> was deinit.")
    }
    
    init() {
        super.init(frame: CGRect.init(), style: .grouped)
        
        initialized()
    }

    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        
        initialized()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initialized() -> Void {
        rowHeight = UITableView.automaticDimension
        estimatedRowHeight = 50
        sectionHeaderHeight = 40
        
        cellLayoutMarginsFollowReadableWidth = false
        
        keyboardDismissMode = .onDrag
        
        tableFooterView = UIView()
    }
}
