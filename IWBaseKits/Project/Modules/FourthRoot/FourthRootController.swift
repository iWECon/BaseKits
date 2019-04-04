//
//  FourthRootController.swift
//  IWBaseKits
//
//  Created by 未来 on 2019/3/29.
//  Copyright © 2019 iWECon. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
class FourthRootController: IWViewController {
    
    var vm: FourthRootViewModel {
        return viewModel as! FourthRootViewModel
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        // Do any additional setup after loading the view.
    }
    
    override func prepareUI() {
        super.prepareUI()
        
<<<<<<< HEAD
=======
        let v = UIView.init(frame: MakeRect(0, 0, 50, 50))
        v.backgroundColor = .red
        self.view.addSubview(v)
        v.top = 80
        v.absRight = 30
>>>>>>> f8f7d1c55a19e14c2d58acaf982e4a1e64edfcb4
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}


