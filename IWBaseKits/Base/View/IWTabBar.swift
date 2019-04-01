//
//  IWTabBar.swift
//  IWBaseKits
//
//  Created by 未来 on 2019/3/29.
//  Copyright © 2019 iWECon. All rights reserved.
//

import UIKit

class IWTabBar: UITabBar {
    
    weak var divider: UIView!
    
    convenience init() {
        self.init(frame: .zero)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // 去除分割线和背景图片
        //        self.shadowImage = UIImage.init()
        //        self.backgroundImage = UIImage.init()
        
        // 添加细线
        let dv = UIView.init()
        dv.backgroundColor = UIColor.init(red: 167.0/255.0, green: 167.0/255.0, blue: 170.0/255.0, alpha: 1.0)
        self.addSubview(dv)
        self.divider = dv
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.bringSubviewToFront(self.divider)
        (self.divider.frame.size).height = 0.5
        (self.divider.frame.size).width = UIScreen.main.bounds.size.width
    }
    
}

