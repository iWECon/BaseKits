//
//  JCollectionViewItemCell.swift
//  IWBaseKits
//
//  Created by suTang on 2019/4/10.
//  Copyright © 2019 iWECon. All rights reserved.
//

import UIKit

class JCollectionViewItemCell: UICollectionViewCell {

    
    @IBOutlet weak var showImage: UIImageView!
    
    @IBOutlet weak var infoLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.showImage.image = UIImage.init(named: "TestshowImage")
        self.infoLabel.text = "花"
    }

}
