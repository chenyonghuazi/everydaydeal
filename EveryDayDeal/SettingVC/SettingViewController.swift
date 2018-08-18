//
//  SettingViewController.swift
//  EveryDayDeal
//
//  Created by Edwin on 2018/1/8.
//  Copyright © 2018年 Edwin. All rights reserved.
//

import UIKit

class SettingViewController: UIViewController {

    @IBOutlet weak var tableV: UITableView!
    let aboutInfo:String = "这是第一个发布版本:version 1.003，如果发现有bug，请联系作者. Email: edwinchenyonghua@gmail.com. 若有不便，请多多见谅."
    
    var settingData:[Int:[settingModel]]?
    var section1:[settingModel]?
    var historySection:[settingModel]?
//    var section1 = [settingModel(info:aboutInfo,category:"Info",title:"About")]
//    var settingData:[Int:[settingModel]] = [0:section1]
    override func viewDidLoad() {
        super.viewDidLoad()
        section1 = [settingModel(info:aboutInfo,category:"Info",title:"About",sectionHeader: "Info")]
        settingData = [0:section1!]
        self.tableV.separatorStyle = .none
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        historySection = [settingModel(info:"", category:"Data", title:"History", sectionHeader: "History")]
        section1 = [settingModel(info:aboutInfo,category:"Info",title:"About",sectionHeader: "Info")]
        settingData = [0:historySection! ,1:section1!]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension SettingViewController: UITableViewDataSource, UITableViewDelegate{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return (settingData?.count)!
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingData![section]!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "settingCell")
        cell.textLabel?.text = settingData![indexPath.section]![indexPath.row].title
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if let model = settingData?[indexPath.section]?[indexPath.row]{
            if model.title == "About"{
                let title = settingData![indexPath.section]![indexPath.row].title
                let message = settingData![indexPath.section]![indexPath.row].info
                let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                alert.addAction(UIAlertAction(title: "Copy", style: .default, handler: { (nil) in
                    UIPasteboard.general.string = "edwinchenyonghua@gmail.com"}))
                present(alert, animated: true, completion: nil)
            }
            
        }
        
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return settingData![section]![0].sectionHeader
    }
    
    
    
}
