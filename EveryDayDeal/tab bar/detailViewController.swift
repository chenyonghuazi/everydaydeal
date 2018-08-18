//
//  detailViewController.swift
//  EveryDayDeal
//
//  Created by Edwin on 2018/1/5.
//  Copyright © 2018年 Edwin. All rights reserved.
//

import UIKit

class detailViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,detailProtocoldelegate {
    //cell's delegate method
    func presentView(brand:String) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let mapVC = storyboard.instantiateViewController(withIdentifier: "MapViewController") as! MapViewController
        mapVC.receivingBrand = brand
        present(mapVC, animated: true, completion: {
            mapVC.receivingBrand = brand
            mapVC.searchRequest()
        })
    }
    
    @IBOutlet weak var tableV: UITableView!
    @IBOutlet weak var navigationBar: UINavigationBar!
    
    var data:[String:String]?
    var receivingData = [String]()
    var naviTitle:String?
    override func viewDidLoad() {
        super.viewDidLoad()
        tableV.delegate = self
        tableV.dataSource = self
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationBar.shadowImage = UIImage()
        navigationBar.isTranslucent = true
        navigationBar.backgroundColor = UIColor.clear
        navigationBar.topItem?.title = naviTitle
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func backButton(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        let lists = Array(receivingData.values)
//        let component = lists[0].components(separatedBy: ",")
//        return component.count
        return receivingData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell2") as! detailTableViewCell
        if let _ = UIImage(named:receivingData[indexPath.row]){
            cell.imageV.image = UIImage(named:receivingData[indexPath.row])
            
            cell.imageV.backgroundColor = UIColor.white
        }else{
            let placeholderImage = #imageLiteral(resourceName: "placeholder2")
            let imageID = URL(string:self.data![receivingData[indexPath.row]]!)
            cell.imageV.sd_setImage(with: imageID, placeholderImage: placeholderImage)
        }
        cell.imageV.contentMode = .scaleAspectFit
        cell.brandName.text = receivingData[indexPath.row]
        cell.brandString = receivingData[indexPath.row]
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            tableView.estimatedRowHeight = 150
            return UITableViewAutomaticDimension
    }
    

}
