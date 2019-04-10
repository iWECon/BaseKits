//
//  MyAlertControlle.swift
//  IWBaseKits
//
//  Created by suTang on 2019/4/10.
//  Copyright © 2019 iWECon. All rights reserved.
//

import UIKit

class MyAlertControlle: UIAlertController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //消息标题样式
        let titleFont = UIFont.systemFont(ofSize: 18, weight: UIFont.Weight(2))
        let titleAttribute = NSMutableAttributedString.init(string:self.title!)
        titleAttribute.addAttributes([NSAttributedString.Key.font:titleFont,NSAttributedString.Key.foregroundColor:UIColor.green], range: NSMakeRange(0, (self.title?.count)!))
        self.setValue(titleAttribute,forKey: "attributedTitle")
        
        
        //消息内容样式

    }
}
