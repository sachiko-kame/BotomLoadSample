//
//  ViewController.swift
//  BotomLoadSample
//
//  Created by 水野祥子 on 2018/03/04.
//  Copyright © 2018年 sachiko. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var sampleArray:Array<String> = [""]
    
    let table = UITableView()
    let ViewFrame = UIScreen.main.bounds

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.table.register(UITableViewCell.self, forCellReuseIdentifier: "MyCell")

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
        return sampleArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath as IndexPath)
        cell.textLabel?.text = sampleArray[indexPath.row]
        return cell
    }
    
    
}

