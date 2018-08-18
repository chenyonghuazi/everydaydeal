//
//  settingModel.swift
//  EveryDayDeal
//
//  Created by Edwin on 2018/1/8.
//  Copyright © 2018年 Edwin. All rights reserved.
//

import Foundation


class settingModel{
    
    var info:String?
    var category:String?
    var title:String?
    var sectionHeader:String?
    init(info:String,category:String,title:String, sectionHeader:String){
        self.info = info
        self.category = category
        self.title = title
        self.sectionHeader = sectionHeader
    }
}
