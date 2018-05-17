//
//  ViewController.swift
//  BotomLoadSample
//
//  Created by 水野祥子 on 2018/03/04.
//  Copyright © 2018年 sachiko. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var sampledatas = [1,2,3,4,5,6,7,8,9,10]
    let table = UITableView()
    let ViewFrame = UIScreen.main.bounds
    var isaddload:Bool = true

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.table.register(UITableViewCell.self, forCellReuseIdentifier: "MyCell")
        self.table.register(cellType: LoaddingTableViewCell.self)
        let footerCell: UITableViewCell = table.dequeueReusableCell(withIdentifier: "LoaddingTableViewCell")!
        (footerCell as! LoaddingTableViewCell).startAnimationg()
        let footerView: UIView = footerCell.contentView
        table.tableFooterView = footerView

        table.frame = ViewFrame
        self.view.addSubview(table)
        
        self.table.dataSource = self
        self.table.delegate = self
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
}

extension ViewController:UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return sampledatas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath as IndexPath)
        cell.textLabel?.text = "\(sampledatas[indexPath.row])"
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        return 130
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if (self.table.contentOffset.y + self.table.frame.size.height > self.table.contentSize.height && self.table.isDragging && isaddload == true){
            self.isaddload = false
            self.addData()
        }
    }
    
    func addData(){
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            for count in 0..<10{
                self.sampledatas.append(count)
            }
            if(self.sampledatas.count > 50){
                self.isaddload = false
                self.table.tableFooterView = UIView()
            }else{
                self.isaddload = true
            }
            self.table.reloadData()
        }
    }
}

