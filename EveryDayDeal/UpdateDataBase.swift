//
//  UpdateDataBase.swift
//  EveryDayDeal
//
//  Created by Edwin on 2017/12/27.
//  Copyright © 2017年 Edwin. All rights reserved.
//

import Foundation
import UIKit

extension ViewController{
    
    func updateDataBase(){
        
        print("doingUpdate")
        handle = fir?.child("image").observe(.childAdded, with: { (snapshot) in
            if snapshot.value != nil{
                if let resources = snapshot.value as? [String:Any]{
                    
                    let newKeys = Array(resources.keys)
                    print(newKeys)
                    print("selfKeys:\(self.keys)")
                    self.keys = self.sortAllIamge(lists: self.keys + newKeys)
                    print("After:selfKeys:\(self.keys)")
//                    self.fir?.removeObserver(withHandle: self.handle!)
                }
                print("goThrough")
                
            }

        })
        self.tableV.reloadData()
    }
    
    func updateDataBase2(){
        var newList = [String]()
        var newWebsite = [String]()
        for key in self.keys{
            handle = fir?.child("image").child(key).observe(.childAdded, with: { (Snapshot) in
                if Snapshot.value != nil{
                    if let dictionary = Snapshot.value as? [String:String]{
                        newList.append(dictionary["imageID"]!)
                        newWebsite.append(dictionary["webAddress"]!)
                        
                    }
                }
            })
        }
        self.urlList = self.urlList + newList
        self.website = self.website + newWebsite
        self.tableV.reloadData()
    }
    
    
}
