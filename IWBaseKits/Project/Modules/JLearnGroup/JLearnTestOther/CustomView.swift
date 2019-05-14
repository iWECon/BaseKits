//
//  CustomView.swift
//  IWBaseKits
//
//  Created by suTang on 2019/4/12.
//  Copyright © 2019 iWECon. All rights reserved.
//

import UIKit

class CustomView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    var infoLabel:UILabel!
    var checkButton:UIButton!
 

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.frame = frame;
        self.backgroundColor = .lightGray
        
        infoLabel = UILabel.init()
        infoLabel.text = "自定义"
        infoLabel.font = UIFont.systemFont(ofSize: 14)
        infoLabel.textColor = .red
        self.addSubview(infoLabel)
        
        checkButton = UIButton.init()
        checkButton.setTitle("查看", for:.normal)
        checkButton.backgroundColor = .black
        checkButton.setTitleColor(.white, for: .normal)
        checkButton.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        self.addSubview(checkButton)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        infoLabel.frame = CGRect(x: 0, y: 0, width: self.bounds.width, height: self.bounds.height/2)
        checkButton.frame = CGRect(x: self.bounds.width/2, y: self.bounds.height/2, width: self.bounds.width/2, height: self.bounds.height/2)
    }

}
