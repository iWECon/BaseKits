//
//  SecondRootController.swift
//  IWBaseKits
//
//  Created by 未来 on 2019/3/29.
//  Copyright © 2019 iWECon. All rights reserved.
//

import UIKit

class SecondRootController: IWViewController,UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datas.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell:UITableViewCell! = tableView.dequeueReusableCell(withIdentifier: "mycell", for: indexPath)
        if cell==nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        }
        cell.textLabel?.text = "这个是第\(datas[indexPath.row].0)个" + datas[indexPath.row].2 + "盒子，编号:" + String(datas[indexPath.row].1)
        return cell
    }
    
    
    var tableView: UITableView!
    var datas: [(String,Int,String)]!
    

//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        view.backgroundColor = .red
//        self.prepareUI()
//
//        // Do any additional setup after loading the view.
//    }
    
    override func prepareUI() {
        super.prepareUI()

        datas = [("1",8,"大"),("2",9,"中"),("3",3,"小")]

        tableView = UITableView(frame: view.bounds, style: .grouped)
        tableView.backgroundColor = UIColor.white
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "mycell")
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
