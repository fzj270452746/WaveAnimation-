//
//  ViewController.swift
//  WaveAnimationDemo
//
//  Created by Jacqui on 2016/11/11.
//  Copyright © 2016年 Jugg. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var tableview: UITableView!
    var waveView: FFWaveView!
    
    var headerImage : UIImageView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 200))
        headerView.backgroundColor = UIColor.gray
        
        headerImage = UIImageView()
        headerImage.layer.cornerRadius = 5
        headerImage.layer.borderWidth = 2
        headerImage.backgroundColor = UIColor.clear
        headerImage.layer.borderColor = UIColor.white.cgColor
        headerImage.layer.masksToBounds = true
        headerView.addSubview(headerImage)
        
        tableview = UITableView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height), style: .plain)
        tableview.delegate = self
        tableview.dataSource = self
        tableview.tableHeaderView = headerView
        tableview.tableFooterView = UIView()
        view.addSubview(tableview)
        
        // FFWaveView setup
        waveView = FFWaveView.addTo(view: tableview.tableHeaderView!, frame: CGRect(x: 0, y: headerView.frame.size.height - 10, width: view.frame.size.width, height: 10))
        
        // optional
        waveView.waveColor = UIColor.white
        waveView.waveSpeed = 10
        waveView.angularSpeed = 1.5
        waveView.waveViewBlock = { [weak self] (wavePoint) in
            self?.headerImage.bounds = CGRect.init(x: 0, y: 0, width: 50, height: 50)
            // 通过回调得到的波浪线在x=centerX时的point，获取其在headerView上的位置即头像的底边中点的坐标
            let point = self?.waveView.convert(wavePoint, to: headerView)
            // 计算头像的originY值
            let headerImageOriginY = (point?.y)! - (self?.headerImage.frame.size.height)!
            self?.headerImage.frame.origin.y = headerImageOriginY
            self?.headerImage.center.x = headerView.center.x
        }
        waveView.startWave()
    }
    
    deinit {
        waveView.stopWave()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

// MARK: - UITableViewDelegate
extension ViewController : UITableViewDelegate {
    
}


// MARK: - UITableViewDataSource
extension ViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableview.dequeueReusableCell(withIdentifier: "cell")
        if  cell == nil {
            cell = UITableViewCell.init(style: .default, reuseIdentifier: "cell")
        }
        cell?.textLabel?.text = "\(indexPath.row)"
        return cell!
    }
}
