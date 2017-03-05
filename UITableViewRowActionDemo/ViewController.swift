//
//  ViewController.swift
//  UITableViewRowActionDemo
//
//  Created by Frank.Chen on 2017/3/5.
//  Copyright © 2017年 Frank.Chen. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var tableView: UITableView!
    var titleDatas: [String] = ["Apple", "Banana", "Cherry"]
    var subTitleDatas: [String] = ["單價:20元", "單價:40元", "單價:10元"]
    var imageDatas: [String] = ["Apple", "Banana", "Cherry"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 產生tableVeiw
        self.tableView = UITableView(frame: CGRect(x: 0, y: 20, width: self.view.frame.size.width, height: self.view.frame.size.height), style: .plain)
        self.tableView?.backgroundColor = UIColor.white
        self.tableView?.delegate = self
        self.tableView?.dataSource = self
        self.view.addSubview(self.tableView)
        
    }

    // MARK: - Table view data source
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.titleDatas.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: "cell")
        }
        
        cell!.textLabel?.text = self.titleDatas[indexPath.row]
        cell!.detailTextLabel?.text = self.subTitleDatas[indexPath.row]
        cell!.imageView?.image = UIImage(named: self.imageDatas[indexPath.row])
        
        return cell!
    }
    
    // MARK: - Table view delegate
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        // 生成刪除按鈕
        let deleteAction: UITableViewRowAction = UITableViewRowAction(style: UITableViewRowActionStyle.default, title: "Delete", handler: {(action, indexPath) -> Void in
            
            // 將資料從陣列移除
            self.titleDatas.remove(at: indexPath.row)
            self.subTitleDatas.remove(at: indexPath.row)
            self.imageDatas.remove(at: indexPath.row)
            
            // 將畫面上的cell移除
            self.tableView.deleteRows(at: [IndexPath(row: indexPath.row, section: 0) as IndexPath], with: UITableViewRowAnimation.fade)
        })
        
        deleteAction.backgroundColor = UIColor.brown
        
        // 生成分享按鈕
        let shareAction: UITableViewRowAction = UITableViewRowAction(style: UITableViewRowActionStyle.default, title: "Share", handler: {(action, indexPath) -> Void in
            
            let text: String = self.titleDatas[indexPath.row]
            let image: UIImage = UIImage(named: self.imageDatas[indexPath.row])!

            let activityViewController: UIActivityViewController =  UIActivityViewController(activityItems: [text, image], applicationActivities: nil)
            self.present(activityViewController, animated: true, completion: nil)
        })
        
        shareAction.backgroundColor = UIColor.darkGray
        
        return [deleteAction, shareAction]
    }
    
}

