//
//  refreshController.swift
//  EveryDayDeal
//
//  Created by Edwin on 2017/12/28.
//  Copyright © 2017年 Edwin. All rights reserved.
//

import Foundation
import UIKit

extension ViewController{
    
    func setRefreshVC(){
        self.refreshController.addTarget(self, action: #selector(ViewController.endrefreshAfterUpdateData), for: .valueChanged)
        self.tableV.refreshControl = self.refreshController
        self.tableV.tableFooterView = self.refreshController
        self.refreshController.attributedTitle = NSAttributedString(string: "Aleady latest")
    }

    @objc func endrefreshAfterUpdateData(){
        print("refreshControllerGetPull")
        
//        self.getAllImage3 { (self) in
//            self.fir?.removeAllObservers()
//        }
        self.refreshController.endRefreshing()
//        self.fir?.removeAllObservers()

    }
    
}
