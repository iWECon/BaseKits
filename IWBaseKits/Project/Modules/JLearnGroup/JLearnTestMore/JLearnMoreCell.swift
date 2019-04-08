//
//  JLearnMoreCell.swift
//  IWBaseKits
//
//  Created by suTang on 2019/4/8.
//  Copyright © 2019年 iWECon. All rights reserved.
//

import UIKit

class JLearnMoreCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var lookDreamBtn: UIButton!
    
    @IBAction func userLookDreamAction(_ sender: UIButton) {
        
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
