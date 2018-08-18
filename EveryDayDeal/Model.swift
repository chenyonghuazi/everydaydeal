//
//  Model.swift
//  EveryDayDeal
//
//  Created by Edwin on 2018/1/5.
//  Copyright © 2018年 Edwin. All rights reserved.
//

import Foundation

class Model{
    var key:String?
    var url:String?
    var webAddress:String?
    var brand:String?
    var category:String?
    
    init(key:String, url:String, webAddress:String, brand:String, category:String) {
        self.key = key
        self.url = url
        self.webAddress = webAddress
        self.brand = brand
        self.category = category
    }
    
    
}
