//
//  ViewController.swift
//  BotomLoadSample
//
//  Created by 水野祥子 on 2018/03/04.
//  Copyright © 2018年 sachiko. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var sampledata = [1,2,3,4,5,6,7,8,9,10]
    
    var loadfrag:Bool = false
    var timeCount:Int = 0
    
    let table = UITableView()
    let ViewFrame = UIScreen.main.bounds
    
    var timer = Timer()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.table.register(UITableViewCell.self, forCellReuseIdentifier: "MyCell")
        self.table.register(cellType: LoaddingTableViewCell.self)

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
       return sampledata.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if(indexPath.row == sampledata.count - 1 && loadfrag == true){
            let cell = tableView.dequeueReusableCell(with: LoaddingTableViewCell.self, for: indexPath)
            cell.IndicatoreView.startAnimating()
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath as IndexPath)
            cell.textLabel?.text = "\(sampledata[indexPath.row])"
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        return 100
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if self.table.contentOffset.y + self.table.frame.size.height > self.table.contentSize.height && self.table.isDragging && loadfrag == false {
            self.IndicatoreViewshow()
        }
    }
    
    func IndicatoreViewshow(){
        loadfrag = true
        sampledata.append(0)
        self.table.reloadData()
    
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(ViewController.onUpdate(timer:)), userInfo: nil, repeats: true)
        
        
    }
    
    @objc func onUpdate(timer : Timer){
        if(timeCount < 2){
            timeCount += 1
        }else{
            sampledata.removeLast()
            for a in sampledata.last!..<sampledata.last! + 10{
                sampledata.append(a)
            }
            timer.invalidate()
            timeCount = 0
            loadfrag = false
            self.table.reloadData()
        }
    }
}

