//
//  JCollectionViewItemCell.swift
//  IWBaseKits
//
//  Created by suTang on 2019/4/10.
//  Copyright © 2019 iWECon. All rights reserved.
//

import UIKit

class JCollectionViewItemCell: UICollectionViewCell {

    
    var vm:JCollectionItemViewModel!
    
    
    @IBOutlet weak var modelBgImage: UIImageView!
    
    @IBOutlet weak var showImage: UIImageView!
    
    @IBOutlet weak var infoLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        backgroundColor = .clear
    }
    
    func bindViewModel(vModel:JCollectionItemViewModel) -> Void {
        
        vm = vModel
        
        //content
        self.showImage.image =  vModel.isHiddenImage==true ? nil : UIImage.init(named: vModel.showImageName)
        self.infoLabel.text = vModel.showInfoString
        
        //UI
        self.setCellDefault()
        
    }
    
    func setCellDefault() {
        
        self.infoLabel.textColor = vm.infoTextColor
        self.infoLabel.isHidden = vm.isHiddenText
        self.showImage.isHidden = vm.isHiddenImage
        
        //是否显示
        if vm.showInfoString.count==0 {
            backgroundColor = vm.isNightMode==true ? .white : .black
        }else{
            backgroundColor = .clear
        }
        //图片高亮
        if vm.isNightMode==true {
            
        }else{
            
        }
    }

}
