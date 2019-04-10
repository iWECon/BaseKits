//
//  TESTViewController.swift
//  IWBaseKits
//
//  Created by 未来 on 2019/4/10.
//  Copyright © 2019 iWECon. All rights reserved.
//

import UIKit

class TESTViewController: UIViewController {
    
    deinit {
        print("老子走了")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        view.addSubview(UITableView.init())
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.dismiss(animated: true, completion: nil)
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
