//
//  UserDefaultMark.swift
//  EveryDayDeal
//
//  Created by Edwin on 2017/12/30.
//  Copyright © 2017年 Edwin. All rights reserved.
//

import Foundation

extension ViewController{
    
    func updateReadingMark(model:Model, path:IndexPath){
        
        var defaultDictionary = [String:String]()
        let key = model.key
        defaultDictionary[key!] = "已读"
        if UserDefaults.standard.value(forKey: "readingMark") != nil{
            var currentData = UserDefaults.standard.value(forKey: "readingMark") as! [String:String]
            currentData[key!] = "已读"
            print("currentData")
            print(currentData)
            UserDefaults.standard.set(currentData, forKey: "readingMark")
            self.tableV.reloadData()
        }
        else{
            
            UserDefaults.standard.set(defaultDictionary, forKey: "readingMark")
            
        }
    }
}
